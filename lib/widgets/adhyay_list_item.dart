import 'package:anubhuti/screens/adhyay_detail_screen.dart';
import 'package:anubhuti/screens/anubhuti_details_screen.dart';
import 'package:flutter/material.dart';

class AdhyayListItem extends StatefulWidget {
  String title;
  int i;
  AdhyayListItem(
    this.title,
    this.i,
  );

  @override
  _AdhyayListItemState createState() => _AdhyayListItemState();
}

class _AdhyayListItemState extends State<AdhyayListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => AdhyayDetailScreen(
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
