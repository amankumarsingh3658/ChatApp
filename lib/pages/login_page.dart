import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final void Function()? onTap;

  LoginPage({super.key , required this.onTap});

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(emailcontroller.text, passwordcontroller.text);
    } catch (e) {
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.message,size: 60,color: Theme.of(context).primaryColor,),
          const SizedBox(height: 50,),
          const Text("Welcome back you have been missed!"),

          const SizedBox(height: 20,),

          MyTextField(hinText: 'Email',controller: emailcontroller),
          const SizedBox(height: 10,),

          MyTextField(hinText: 'Password',isObsecure: true,controller: passwordcontroller),

          const SizedBox(height: 25,),

          MyButton(text: 'Login',onTap: ()=> login(context)),
          const SizedBox(height: 25,),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Not A Member? "),
              GestureDetector(
                onTap: onTap,
                child: const Text("Register Now",style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          )
        ],),
      ),
    );
  }
}