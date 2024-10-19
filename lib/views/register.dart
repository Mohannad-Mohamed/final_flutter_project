import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/views/log_in.dart';
import 'package:news_app_ui_setup/widgets/button.dart';
import 'package:news_app_ui_setup/widgets/icon_button.dart';
import 'package:news_app_ui_setup/widgets/text_field.dart';

import '../services/icon_auth_service.dart';
import '../widgets/hidden_drawer.dart';

class Register extends StatefulWidget{


  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();

  void errorDialog (String massage){
    showDialog(context: context, builder: (context){
      return AlertDialog(title: Center(child: Text(massage,style: TextStyle(color: Colors.blue),)),backgroundColor: Colors.white,);
    });
  }

  void buttonPressed () async {

    if(passwordController.text == repeatPasswordController.text) {
      showDialog(context: context,builder: (context){
        return Center(child: CircularProgressIndicator(color: Colors.blueAccent,));
      });
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
      }
      on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == 'too-many-request')
          errorDialog("Close application and open again");
        else
          errorDialog(e.code);
      }
    }
    else
      errorDialog("Password not equal Repeated Password");

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue[50],
      resizeToAvoidBottomInset: false, // Prevents the keyboard from resizing the screen
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Spacer(),
                        CircleAvatar(
                          child: Image.asset('assets/1759492.png', fit: BoxFit.cover),
                          radius: 70,
                        ),
                        Spacer(),
                        Text(
                          "Create Your Acount",
                          style: TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                        SizedBox(height: 30),
                        MyTextField(controller: emailController, hint: "Email", isPassword: false),
                        SizedBox(height: 10),
                        MyTextField(controller: passwordController, hint: "Password", isPassword: true),
                        SizedBox(height: 10),
                        MyTextField(controller: repeatPasswordController, hint: "Repeat Password", isPassword: true),
                        SizedBox(height: 25),
                        MyButton(text: "Register", onPressed: buttonPressed),
                        SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                              Text("Or continue with", style: TextStyle(color: Colors.grey)),
                              Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                            ],
                          ),
                        ),
                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyIconButton(path: 'assets/1759492.png',signInMethod: IconAuth().signInWithGoogle,),
                            SizedBox(width: 15),
                            MyIconButton(path: 'assets/1759492.png',signInMethod: IconAuth().signInWithGoogle,),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Have account? ",style: TextStyle(color: Colors.grey),),
                            GestureDetector(
                              child: Text("Log in now"),
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogIn()),
                                );
                              },
                            )                          ],
                        ),
                        Spacer(),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );


  }
}