


import 'package:anubhuti/screens/adhay_list_screen.dart';
import 'package:anubhuti/screens/admin_screen.dart';
import 'package:anubhuti/screens/home_screen.dart';
import 'package:anubhuti/screens/new_adhyay_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(elevation: 10,
      child: Column(
        children: [
          AppBar(
            title: const Text("अनुभूती !!!"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Admin"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c)=> AdminScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_travel_outlined),
            title: const Text("User"),
            onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (c)=> HomeScreen()));
            },
          ),
           ListTile(
            leading: const Icon(Icons.book_online_rounded),
            title: const Text("Adhyay"),
            onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (c)=> NewAdhyayScreen()));
            },
          ),
           ListTile(
            leading: const Icon(Icons.book_online_rounded),
            title: const Text("Adhyay List"),
            onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (c)=> AdhyayListScreen()));
            },
          ),
         
        ],
      ),
      
    );
  }
}