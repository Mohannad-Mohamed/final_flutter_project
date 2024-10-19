import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/services/icon_auth_service.dart';
import 'package:news_app_ui_setup/views/register.dart';
import 'package:news_app_ui_setup/widgets/button.dart';
import 'package:news_app_ui_setup/widgets/icon_button.dart';
import 'package:news_app_ui_setup/widgets/text_field.dart';

import '../widgets/hidden_drawer.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void errorDialog(String massage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text(
              massage,
              style: TextStyle(color: Colors.blue),
            )),
            backgroundColor: Colors.white,
          );
        });
  }

  void buttonPressed() async {

    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHiddenDrawer()));
    }
    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'invalid-email')
        errorDialog("Invaild Email");
      else if (e.code == 'invalid-credential')
        errorDialog("Invaild Password");
      else if (e.code == 'too-many-request')
        errorDialog("Close application and open again");
      else
        errorDialog(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      resizeToAvoidBottomInset:
          false, // Prevents the keyboard from resizing the screen
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
                          child: Image.asset('assets/1759492.png',
                              fit: BoxFit.cover),
                          radius: 70,
                        ),
                        Spacer(),
                        Text(
                          "Welcome Back",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                        SizedBox(height: 30),
                        MyTextField(
                            controller: emailController,
                            hint: "Email",
                            isPassword: false),
                        SizedBox(height: 10),
                        MyTextField(
                            controller: passwordController,
                            hint: "Password",
                            isPassword: true),
                        SizedBox(height: 25),
                        MyButton(text: "Log in", onPressed: buttonPressed),
                        SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                      color: Colors.grey, thickness: 0.5)),
                              Text("Or continue with",
                                  style: TextStyle(color: Colors.grey)),
                              Expanded(
                                  child: Divider(
                                      color: Colors.grey, thickness: 0.5)),
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
                            Text(
                              "Create account? ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            GestureDetector(
                              child: Text("Register now"),
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()),
                                );
                              },
                            )
                          ],
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
