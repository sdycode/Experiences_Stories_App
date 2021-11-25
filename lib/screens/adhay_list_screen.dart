import 'package:anubhuti/providers/items.dart';
import 'package:anubhuti/screens/new_anubhav_screen.dart';
import 'package:anubhuti/widgets/adhyay_list_item.dart';
import 'package:anubhuti/widgets/app_drawer.dart';
import 'package:anubhuti/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdhyayListScreen extends StatefulWidget {
  const AdhyayListScreen({Key? key}) : super(key: key);

  @override
  _AdhyayListScreenState createState() => _AdhyayListScreenState();
}

class _AdhyayListScreenState extends State<AdhyayListScreen> {
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
    var providerItems = Provider.of<Items>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("अनुभूती")),
      drawer: AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            
            Expanded(
              child: Container(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : providerItems.allItems.length == 0
                        ? Center(
                            child: Text(monthValue +
                                " " +
                                yearValue +
                                " मध्ये कोणताही अनुभव नाही "),
                          )
                        : ListView.builder(
                            itemBuilder: (ctx, i) {
                              return AdhyayListItem(
                                  providerItems.ads.elementAt(i).title, i + 1);
                            },
                            itemCount: providerItems.ads.length,
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
                        setState(() {
                          isLoading = true;
                          providerItems.getAndSetAllAdhyays();
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

 
  void _addNewAnubhuti(String selectedYearMonth, Items providerItems) {
    String anubhavId = selectedYearMonth;
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return NewAnubhavScreen();
    }));
  }
}
