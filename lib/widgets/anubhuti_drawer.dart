


import 'package:anubhuti/screens/admin_home_screen.dart';
import 'package:anubhuti/screens/admin_screen.dart';
import 'package:anubhuti/screens/admin_updated_screen.dart';
import 'package:anubhuti/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AnubhutiDrawer extends StatefulWidget {
  const AnubhutiDrawer({ Key? key }) : super(key: key);

  @override
  _AnubhutiDrawerState createState() => _AnubhutiDrawerState();
}

class _AnubhutiDrawerState extends State<AnubhutiDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(elevation: 10,
      child: Column(
        children: [
          AppBar(
            title: const Text("Admin ..."),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
           ListTile(
            leading: const Icon(Icons.face_retouching_natural),
            title: const Text("User "),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c)=> HomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.five_mp_rounded),
            title: const Text("Sample Anubhutis !!!"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c)=> AdminHomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_travel_outlined),
            title: const Text("Updated Anubhutis"),
            onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (c)=> AdminUpdatedScreen()));
            },
          ),
         
        ],
      ),
      
    );
  }
}