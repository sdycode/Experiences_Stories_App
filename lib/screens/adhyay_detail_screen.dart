import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:anubhuti/providers/items.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

class AdhyayDetailScreen extends StatefulWidget {
  int i;
  AdhyayDetailScreen({
    required this.i,
  });

  @override
  _AdhyayDetailScreenState createState() => _AdhyayDetailScreenState();
}

enum TtsState { playing, stopped, paused, continued }

class _AdhyayDetailScreenState extends State<AdhyayDetailScreen> {
  FlutterTts flutterTts = FlutterTts();
  String story = "स्वामींचा अनुभव लोड होत आहे !!!";
  String personName = "नाव";
  String cityName = "दिंडोरी";
  String year = "वर्ष";
  String month = "महिना";
  String title = "";
  double playSpeed = 1;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  String? language;
  bool isCurrentLanguageInstalled = false;
  bool isSpeedSliderSelected = true;

  TtsState ttsState = TtsState.stopped;
  bool isPaused = false;

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
  @override
  void initState() {
    super.initState();
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double SCREEN_WIDTH = MediaQuery.of(context).size.width;
    double SCREEN_HEIGHT = MediaQuery.of(context).size.height;
    var providerItems = Provider.of<Items>(context, listen: false);
    String id = providerItems.allItems.elementAt(widget.i - 1).id;
    getAllDataFromId(id);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("स्वामींचा अनुभव"),
      // ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            width: SCREEN_WIDTH,
            child: Text(
              providerItems.allAdhyays.elementAt(widget.i - 1).title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              // height: SCREEN_HEIGHT * 0.7,

              width: SCREEN_WIDTH,
              margin: const EdgeInsets.all(4),
              child: Card(
                elevation: 5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  dragStartBehavior: DragStartBehavior.start,
                  controller: ScrollController(debugLabel: "1"),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                       providerItems.allAdhyays.elementAt(widget.i - 1).story,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(4),
              width: SCREEN_WIDTH,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    year,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    personName.length >= 29
                        ? personName.substring(0, 30)
                        : personName,
                    // personName,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.all(4),
              width: SCREEN_WIDTH,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    month,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    cityName,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          Container(
            width: SCREEN_WIDTH,
            margin: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () => _speak(),
                  child: const Text("ऐका"),
                ),
                // pauseButton(),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    setState(() {
                      flutterTts.stop();
                      ttsState = TtsState.stopped;
                    });
                  },
                  child: const Text("थांबवा"),
                ),
              ],
            ),
          ),
          Container(
            width: SCREEN_WIDTH,
            margin: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: !isSpeedSliderSelected
                        ? MaterialStateProperty.all(Colors.deepPurple)
                        : MaterialStateProperty.all(Colors.grey),
                  ),
                  onPressed: () {
                    setState(() {
                      isSpeedSliderSelected = false;
                    });
                  },
                  child: const Text("pitch"),
                ),
                isSpeedSliderSelected ? _rate() : _pitch(),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: isSpeedSliderSelected
                        ? MaterialStateProperty.all(Colors.deepPurple)
                        : MaterialStateProperty.all(Colors.grey),
                  ),
                  onPressed: () {
                    setState(() {
                      isSpeedSliderSelected = true;
                    });
                  },
                  child: const Text("speed"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _languageDropDownSection(dynamic languages) => Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: language,
          items: getLanguageDropDownMenuItems(languages),
          onChanged: changedLanguageDropDownItem,
        ),
        Visibility(
          visible: true,
          child: Text("Is installed: $isCurrentLanguageInstalled"),
        ),
      ]));
  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
      dynamic languages) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in languages) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  void changedLanguageDropDownItem(String? selectedType) {
    setState(() {
      String lang = selectedType!;
      setState(() {
        language = selectedType;
      });
      // flutterTts.setLanguage(lang);
      print("lang is " +
          flutterTts.isLanguageInstalled(lang).toString() +
          "name " +
          lang);

      flutterTts
          .isLanguageInstalled(language!)
          .then((value) => isCurrentLanguageInstalled = (value as bool));
    });
  }

  Widget _futureBuilder() => FutureBuilder<dynamic>(
      future: _getLanguages(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _languageDropDownSection(snapshot.data);
        } else if (snapshot.hasError) {
          return const Text('Error loading languages...');
        } else {
          return const Text('Loading Languages...');
        }
      });
  Widget getBoldedText(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _volume() {
    return Slider(
        value: volume,
        onChanged: (newVolume) {
          setState(() => volume = newVolume);
        },
        min: 0.0,
        max: 1.0,
        divisions: 50,
        label: "Volume: $volume");
  }

  Widget _pitch() {
    return Slider(
      value: pitch,
      onChanged: (newPitch) {
        setState(() => pitch = newPitch);
      },
      min: 0.5,
      max: 2.0,
      divisions: 50,
      label: "Pitch: $pitch",
      activeColor: Colors.deepPurple,
    );
  }

  Widget _rate() {
    return Slider(
      value: rate,
      onChanged: (newRate) {
        setState(() => rate = newRate);
      },
      min: 0.0,
      max: 1.0,
      divisions: 50,
      label: "Speed: $rate",
      activeColor: Colors.deepPurple,
    );
  }

  Future<void> getAllDataFromId(String id) async {
    String url =
        "https://sellershopapp-default-rtdb.firebaseio.com/Anubhutis/" +
            id +
            ".json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      final data = json.decode(response.body);
      String anubhutiId = data['anubhutiId'];

      setState(() {
        story = data['story'];
        personName = data['personName'];
        year = anubhutiId.substring(0, 4);
        String index = anubhutiId.substring(4);
        title = data['title'];
        month = months.elementAt(int.parse(index) - 1);
        cityName = data['cityName'];
      });
      print("id  : --- " + id);
      // print("Data is "+data["-Mm7AHxmjXNZww9e75sA"]);
      // data.forEach((prodId, prod) {
      //   // print("Prod ID : " + prod[0]);
      // });
      // _items = itemsFromDatabase;

    } catch (error) {
      rethrow;
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    await flutterTts.setLanguage('mr-IN');
    String totalStory = "";
    String updatedStory = "";
    setState(() {
      updatedStory = story.replaceAll("प.पू.", "परमपूज्य");
    });

    String titleText = "अनुभवाचे शीर्षक आहे. " + title + " ";
    String intro =
        "श्रीस्वामी समर्थ आणि परमपूज्य गुरुमाऊली यांच्‍या चरणी त्रिवार मुजरा.";
    String experience =
        "हा अनुभव " + cityName + " येथील " + personName + "यांना आलेला आहे.";
    String time =
        "हा अनुभव " + year + "च्या" + month + ". च्या मासिकात आलेला आहे.";

    totalStory = intro +
        experience +
        time +
        titleText +
        updatedStory +
        ". श्री स्वामी समर्थ ";
    setState(() {
      ttsState = TtsState.playing;
    });
    flutterTts.speak(totalStory);
  }

  Widget speedButton(BuildContext ctx, double i) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      child: ElevatedButton(
        child: Text(
          i.toString(),
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          setState(() {
            playSpeed = i;
          });
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
        ),
      ),
    );
  }

  Widget pauseButton() {
    return ElevatedButton(
      onPressed: () {
        _pause();
        setState(() {
          isPaused = !isPaused;
        });
      },
      child: isPaused ? const Text("पुन्हा सुरू") : const Text("विराम द्या"),
    );
  }
}
