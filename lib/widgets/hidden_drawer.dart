import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:news_app_ui_setup/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/authentication.dart';

class MyHiddenDrawer extends StatefulWidget {
  const MyHiddenDrawer({super.key});

  @override
  State<MyHiddenDrawer> createState() => _MyHiddenDrawerState();
}

class _MyHiddenDrawerState extends State<MyHiddenDrawer> {
  List<ScreenHiddenDrawer> drawer = [];
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    drawer = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Home",
              baseStyle: TextStyle(),
              selectedStyle: TextStyle(color: Colors.white),
              colorLineSelected: Colors.blueAccent),
          HomeView()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Log out\nEmail: " + user!.email!,
              baseStyle: TextStyle(),
              selectedStyle: TextStyle(),
              onTap: ()  {FirebaseAuth.instance.signOut();Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Authentication()));},
              colorLineSelected: Colors.blueAccent),
          Authentication())
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: drawer,
      backgroundColorMenu: Colors.blue.shade100,
      withAutoTittleName: false,
      slidePercent: 60,
      verticalScalePercent: 90,
      backgroundColorAppBar: Colors.blueAccent,
    );
  }
}
