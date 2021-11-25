import 'package:anubhuti/providers/items.dart';
import 'package:anubhuti/screens/new_anubhav_screen.dart';
import 'package:anubhuti/widgets/admin_list_item.dart';
import 'package:anubhuti/widgets/admin_updated_list_item.dart';
import 'package:anubhuti/widgets/anubhuti_drawer.dart';
import 'package:anubhuti/widgets/app_drawer.dart';
import 'package:anubhuti/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminUpdatedScreen extends StatefulWidget {
  const AdminUpdatedScreen({Key? key}) : super(key: key);

  @override
  _AdminUpdatedScreenState createState() => _AdminUpdatedScreenState();
}

class _AdminUpdatedScreenState extends State<AdminUpdatedScreen> {
  bool isLoading = false;
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
    var providerItems = Provider.of<Items>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("अनुभूती")),
      drawer:AnubhutiDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                getYearSelector(SCREEN_WIDTH),
                getMonthSelector(SCREEN_WIDTH)
              ],
            ),
            Expanded(
              child: Container(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : providerItems.allItems.length == 0
                        ?  Center(
                            child: Text(monthValue+" "+ yearValue+ " मध्ये कोणताही अनुभव नाही "
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (ctx, i) {
                              return AdminUpdatedListItem(
                                 i:  i + 1, id:  providerItems.allItems.elementAt(i).getId, title:  providerItems.allItems.elementAt(i).getTitle);
                            },
                            itemCount: providerItems.allItems.length,
                          ),
              ),
            ),
            Container(
              width: SCREEN_WIDTH,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _addNewAnubhuti(selectedYearMonth, providerItems);
                      },
                      child: const Text("नवीन अनुभव जोडा")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                          providerItems
                              .getAndSetItems(selectedYearMonth)
                              .then((value) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        });
                        print("Tapped");
                      },
                      child: Text(selectedYearMonth.substring(0,4)+"- "+months[int.parse(choosedMonth)-1])),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                          providerItems.getAndSetAllItems().then((value) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        });
                        print("Tapped");
                      },
                      child: const Text("संपूर्ण")),
                ],
              ),
            )
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
                    print("month before 10" + selectedYearMonth);
                  } else {
                    selectedYearMonth += (i + 1).toString();
                    choosedMonth = (i + 1).toString();
                    print("month after 10" + selectedYearMonth);
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
                  yearValue = newValue!.toString();
                  choosedYear = newValue;
                  selectedYearMonth = newValue.toString() + choosedMonth;
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

  void _addNewAnubhuti(String selectedYearMonth, Items providerItems) {
    String anubhavId = selectedYearMonth;
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return NewAnubhavScreen();
    }));
  }
}
