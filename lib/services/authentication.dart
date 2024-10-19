import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/views/log_in.dart';
import 'package:news_app_ui_setup/widgets/hidden_drawer.dart';

import '../views/home_view.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
        if(snapshot.hasData)
          return MyHiddenDrawer();

        else
          return LogIn();
      }),
    );
  }
}
