import 'dart:convert';

import 'package:anubhuti/models/list_item_model.dart';
import 'package:anubhuti/providers/items.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:anubhuti/screens/admin_anubhuti_detail_screen.dart';
import 'package:anubhuti/screens/anubhuti_details_screen.dart';

class AdminListItem extends StatefulWidget {
  String title;
  String id;
  int i;
  AdminListItem({
    Key? key,
    required this.title,
    required this.id,
    required this.i,
  }) : super(key: key);

  @override
  _AdminListItemState createState() => _AdminListItemState();
}

class _AdminListItemState extends State<AdminListItem> {
  String story = "स्वामींचा अनुभव लोड होत आहे !!!";
  String personName = "नाव";
  String cityName = "दिंडोरी";
  String year = "वर्ष";
  String month = "महिना";
  String title = "";
  String anubhutiId = "";
  List<String> months = [
    "जानेवारी",
    "फेब्रुवारी",
    "मार्च",
    "एप्रिल",
    "मे",
    "जून",
    "जुलै",
    "ऑगस्ट",
    "सप्टेंबर",
    "ऑक्टोबर",
    "नोव्हेंबर",
    "डिसेंबर",
  ];
  MaterialColor addIconColor = Colors.orange;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerItems = Provider.of<Items>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => AdminAnubhutiDetailsScreen(
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
              IconButton(
                  onPressed: () {
                    if (providerItems.sampleAllItems.length > 1) {
                      deleteSampleAnubhuti(providerItems);
                    } else {
                      SnackBar snackBar = const SnackBar(
                        content: Text("First sample cant be deleted !!!"),
                        backgroundColor: Colors.orange,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  icon: const Icon(Icons.delete_forever)),
              IconButton(
                  onPressed: () {
                    _addSampleToUpdated(providerItems);
                  },
                  icon: Icon(
                    Icons.add_alert_rounded,
                    color: addIconColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addSampleToUpdated(Items providerItems) async {
    print("_addSampleToUpdated called");
    setState(() {
      addIconColor = Colors.red;
    });
    String url =
        "https://sellershopapp-default-rtdb.firebaseio.com/Sample_Anubhutis/" +
            widget.id +
            ".json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      final data = json.decode(response.body);
      anubhutiId = data['anubhutiId'];

      setState(() {
        if (data['isUpdated'] == true) {
          addIconColor = Colors.red;
        }
        story = data['story'];
        personName = data['personName'];
        year = anubhutiId.substring(0, 4);
        String index = anubhutiId.substring(4);
        title = data['title'];
        month = months.elementAt(int.parse(index) - 1);
        cityName = data['cityName'];
      });
    } catch (error) {
      rethrow;
    }

    const posturl =
        "https://sellershopapp-default-rtdb.firebaseio.com/Anubhutis.json";
    Uri posturi = Uri.parse(posturl);
    try {
      final response = await http
          .post(posturi,
              body: json.encode({
                'anubhutiId': anubhutiId,
                'personName': personName,
                'cityName': cityName,
                'story': story,
                'title': title,
                'isUpdated': true,
              }))
          .then((value) {
        setState(() {
          // isLoading = false;
        });
      });
      var backendId = json.decode(response.body);
      print("Backend Id " + backendId['name']);
      ListItemModel item = ListItemModel(
          id: backendId['name'],
          anubhutiId: anubhutiId,
          title: title,
          isUpdated: true);
      setState(() {
        providerItems.addSampleItem(item);
      });
    } catch (error) {
      print("Error in addition " + error.toString());
      throw error;
    }
  }

  Future<void> deleteSampleAnubhuti(Items providerItems) async {
    String url1 =
        "https://sellershopapp-default-rtdb.firebaseio.com/Sample_Anubhutis/" +
            widget.id +
            ".json";
    Uri uri1 = Uri.parse(url1);
    try {
      final res = await http.delete(uri1);
      final getRes = await http.get(uri1);
      print("res : " + res.body);
      print("Get res  : " + getRes.body);
      providerItems.deleteSampleItem();
      SnackBar snackBar = const SnackBar(
        content: Text("deleted"),
        backgroundColor: Colors.black,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      print("Error in addition " + error.toString());
      throw error;
    }
  }
}
