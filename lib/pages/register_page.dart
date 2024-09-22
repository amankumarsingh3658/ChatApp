import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
   RegisterPage({super.key , required this.onTap});

    final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  final confirmpasswordcontroller = TextEditingController();

  final namecontroller = TextEditingController();

  final phonecontroller = TextEditingController();

  void register(BuildContext context) async {
    final authService = AuthService();
    if(passwordcontroller.text == confirmpasswordcontroller.text){
      try {
      await authService.signUpWithEmailAndPassword(emailcontroller.text, passwordcontroller.text,namecontroller.text,phonecontroller.text);

        
      } catch (e) {
        showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text(e.toString()),
      ));
        
      }
    }else{
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text("Password dont match"),
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
          const Text("Lets Create an Account for you"),

          const SizedBox(height: 20,),

          MyTextField(hinText: 'Name',controller: namecontroller),
          const SizedBox(height: 10,),
          MyTextField(hinText: 'Email',controller: emailcontroller),
          const SizedBox(height: 10,),
          MyTextField(hinText: 'Phone',controller: phonecontroller),
          const SizedBox(height: 10,),

          MyTextField(hinText: 'Password',isObsecure: true,controller: passwordcontroller),
          const SizedBox(height: 10,),

          MyTextField(hinText: 'Confirm Password',isObsecure: true,controller: confirmpasswordcontroller),

          const SizedBox(height: 25,),

          MyButton(text: 'Sign Up',onTap:()=> register(context)),
          const SizedBox(height: 25,),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already A Member? "),
              GestureDetector(
                onTap: onTap,
                child: const Text("Login Now",style: TextStyle(fontWeight: FontWeight.bold),)),
            ],
          )
        ],),
      ),
    );
  }
}