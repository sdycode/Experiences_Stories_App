import 'package:anubhuti/screens/anubhuti_details_screen.dart';
import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  String title;
  int i;
  ListItem(
    this.title,
    this.i,
  );

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => AnubhutiDetailsScreen(
                        i: widget.i,
                      )));
        },
        child: Card(
          elevation: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                alignment: Alignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(
                    Icons.circle,
                    color: Colors.indigo,
                    size: 35,
                  ),
                  Text(
                    widget.i.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 25,
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
