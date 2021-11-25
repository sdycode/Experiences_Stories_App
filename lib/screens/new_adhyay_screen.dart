import 'dart:convert';

import 'package:anubhuti/models/adhyay_model.dart';
import 'package:anubhuti/models/list_item_model.dart';
import 'package:anubhuti/providers/items.dart';
import 'package:anubhuti/screens/user_sample_anubhuti_screen.dart';
import 'package:anubhuti/widgets/list_item.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class NewAdhyayScreen extends StatefulWidget {
  const NewAdhyayScreen({Key? key}) : super(key: key);

  @override
  _NewAdhyayScreenState createState() => _NewAdhyayScreenState();
}

class _NewAdhyayScreenState extends State<NewAdhyayScreen> {
// Date

  String monthValue = "जानेवारी";
  String yearValue = "2021";
  String selectedYearMonth = "202101";
  String choosedYear = "2021";
  String choosedMonth = "01";

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
  List<String> years = [];
//
  String anubhutiId = "";
  String personName = "";
  String cityName = "";
  String story = "";
  String title = "";
  bool isLoading = false;
  @override
  void initState() {
    for (int i = 2021; i >= 2000; i--) {
      years.add(i.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double SCREEN_WIDTH = MediaQuery.of(context).size.width;
    double SCREEN_HEIGHT = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber[400],
          foregroundColor: Colors.black87,
          title: const Text("नवीन adhyay"),
          actions: [
            IconButton(
                onPressed: () {},
                // _showSampleAnubhutis,
                icon: const Icon(Icons.list_alt_rounded),
                color: Colors.green[700]),
            IconButton(
              onPressed: _saveForm,
              icon: const Icon(Icons.save),
              color: Colors.black,
            ),
            IconButton(
              onPressed: _clearAllFields,
              icon: const Icon(Icons.cancel_rounded),
              color: Colors.red,
            ),
          ]),
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
          : Container(
              height: SCREEN_HEIGHT,
              width: SCREEN_WIDTH,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(4),
                    height: SCREEN_HEIGHT * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Colors.black, // red as border color
                      ),
                    ),
                    child: SizedBox.expand(
                      child: Text(title),
                    ),
                  ),
                  SizedBox(
                    width: SCREEN_WIDTH,
                    height: SCREEN_HEIGHT * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("अनुभव शीर्षक"),
                        ElevatedButton(
                          onPressed: () {
                            FlutterClipboard.paste().then((value) {
                              setState(() {
                                title = title + " " + value;
                              });
                            });
                          },
                          child: const Text("paste"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              title = "";
                            });
                          },
                          child: const Text("clear"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      height: SCREEN_HEIGHT * 0.8,
                      width: SCREEN_WIDTH,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.black, // red as border color
                        ),
                      ),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical, child: Text(story)),
                    ),
                  ),
                  SizedBox(
                    width: SCREEN_WIDTH,
                    height: SCREEN_HEIGHT * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("संपूर्ण अनुभव"),
                        ElevatedButton(
                          onPressed: () {
                            FlutterClipboard.paste().then((value) {
                              setState(() {
                                story += " " + value;
                              });
                            });
                          },
                          child: const Text("paste"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              story = "";
                            });
                          },
                          child: const Text("clear"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget getMonthSelector(double width) {
    return Container(
      width: width * 0.5,
      padding: const EdgeInsets.all(8),
      child: DropdownButton<String>(
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
          value: monthValue,
          onChanged: (String? newValue) {
            for (int i = 0; i < months.length; i++) {
              if (months[i] == newValue) {
                setState(() {
                  monthValue = newValue!;

                  print("Month " + monthValue);
                  if (selectedYearMonth.length > 3) {
                    selectedYearMonth = selectedYearMonth.substring(0, 4);
                  }

                  if (i < 9) {
                    selectedYearMonth += "0" + (i + 1).toString();
                    choosedMonth = "0" + (i + 1).toString();
                    print("month before 10 - " + selectedYearMonth);
                  } else {
                    selectedYearMonth += (i + 1).toString();
                    choosedMonth = (i + 1).toString();
                    print("month after 10 - " + selectedYearMonth);
                  }
                });
              }
            }
          },
          isExpanded: true,
          isDense: true,
          items: months.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              alignment: Alignment.center,
              value: value,
              child: SizedBox(
                child: Text(
                  value,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
                width: MediaQuery.of(context).size.width * 0.5,
                height: 40,
              ),
            );
          }).toList()),
    );
  }

  Widget getYearSelector(double width) {
    return Container(
      width: width * 0.5,
      padding: const EdgeInsets.all(8),
      child: DropdownButton<String>(
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
          value: yearValue,
          onChanged: (String? newValue) {
            for (int i = 0; i < years.length; i++) {
              if (years[i] == newValue) {
                setState(() {
                  selectedYearMonth = choosedYear + choosedMonth;
                  yearValue = newValue!.toString();
                  selectedYearMonth = newValue.toString();
                  selectedYearMonth += choosedMonth;
                  choosedYear = newValue;
                });

                print("Year : " + yearValue);
              }
            }
          },
          isExpanded: true,
          isDense: true,
          items: years.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              alignment: Alignment.center,
              value: value,
              child: SizedBox(
                child: Text(
                  value,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
                width: MediaQuery.of(context).size.width * 0.5,
                height: 40,
              ),
            );
          }).toList()),
    );
  }

  Future<void> _saveForm() async {
    var providerItems = Provider.of<Items>(context, listen: false);

    if (story.isNotEmpty || title.isNotEmpty) {
      setState(() {
        isLoading = true;
        anubhutiId = selectedYearMonth;
      });
      const url =
          "https://sellershopapp-default-rtdb.firebaseio.com/Adhyay.json";
      Uri uri = Uri.parse(url);
      try {
        final response = await http
            .post(uri,
                body: json.encode({
                  'title': title,
                  'story': story,
                }))
            .then((value) {
          setState(() {
            isLoading = false;
          });
        });
        var backendId = json.decode(response.body);
        print("Backend Id " + backendId['name']);
        Adhyay item = Adhyay(story: story, title: title);
        providerItems.addAdhyay(item);
      } catch (error) {
        print("Error in addition " + error.toString());
        throw error;
      }
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text('PLease enter all deatils'),
        backgroundColor: Colors.red,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // const SnackBar(content:  Text("Please fill all details"));
      // Toast.s ("Toast plugin app", context, duration: Toast.LENGTH_LONG, );

      // Fluttertoast.showToast(
      //     msg: "Please fill all details",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  void _clearAllFields() {
    setState(() {
      personName = "";
      story = "";
      cityName = "";
      title = "";
    });
  }

  void _showSampleAnubhutis() {
    Navigator.push(context,
        MaterialPageRoute(builder: (ctx) => const UserSampleAnubhutisScreen()));
  }
}
