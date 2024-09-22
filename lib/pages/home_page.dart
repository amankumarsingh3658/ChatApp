import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final _chatService = ChatService();
  final _authService = AuthService();

  void logout()async {
    final AuthService authService = AuthService();
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),actions: [
        IconButton(onPressed: logout, icon: Icon(Icons.logout))
      ],),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(stream: _chatService.getUserStream(), builder: (context , snapshot){
      // error
      if(snapshot.hasError){
        return Text("Error");
      }
      if(snapshot.connectionState ==ConnectionState.waiting){
        return Text("Loading");
      }

      return ListView(
        children: snapshot.data!.map<Widget>((userData)=>_buildUserListItem(userData , context)).toList(),
      );
    });
  }

  Widget _buildUserListItem(Map<String , dynamic> userData,BuildContext context){
    if(userData["email"] != _authService.getCurrentUser()!.email){
      return UserTile(text: userData["name"],onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(recieverName: userData["name"] , recieverId: userData["uid"],)));
    },);
    }else{
      return Container();
    }
  }
}