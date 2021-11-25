import 'dart:convert';
import 'package:anubhuti/models/adhyay_model.dart';
import 'package:anubhuti/models/list_item_model.dart';
import 'package:anubhuti/widgets/adhyay_list_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Items with ChangeNotifier {
  List<ListItemModel> _items = [];
  List<ListItemModel> get allItems {
    return [..._items];
  }

  List<Adhyay> _adhyays = [];
  List<Adhyay> get allAdhyays {
    return [..._adhyays];
  }

  List<AdhyayListItem> ads = [];
  List<AdhyayListItem> get allAds {
    return [...ads];
  }

  void addAdhyay(Adhyay model) {
    _adhyays.add(model);
    notifyListeners();
  }

  List<ListItemModel> _sampleItems = [];
  List<ListItemModel> get sampleAllItems {
    return [..._sampleItems];
  }

  void deleteSampleItem() {
    getAndSetAllSampleItems();
    notifyListeners();
  }

  void addSampleItem(ListItemModel model) {
    _sampleItems.add(model);
    notifyListeners();
  }

  void addItem(ListItemModel model) {
    _items.add(model);
    notifyListeners();
  }

  Future<void> getAndSetItems(String selectedYearMonth) async {
    const url =
        "https://sellershopapp-default-rtdb.firebaseio.com/Anubhutis.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      final data = json.decode(response.body) as Map<String, dynamic>;
      _items.clear();
      final List<ListItemModel> itemsFromDatabase = [];
      print("response : --- " + data.toString());
      // print("Data is "+data["-Mm7AHxmjXNZww9e75sA"]);
      data.forEach((prodId, prod) {
        if (prod['anubhutiId'].toString() == selectedYearMonth) {
          _items.add(ListItemModel(
              id: prodId,
              anubhutiId: prod['anubhutiId'].toString(),
              title: prod['title'].toString(),
              isUpdated: prod['isUpdated']));
        } else {}
        print("Id  : " + prodId);
        print("Body " + prod['anubhavId'].toString());
        // print("Prod ID : " + prod[0]);
      });
      print("Items size is  : " + _items.length.toString());
      notifyListeners();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> getAndSetAllAdhyays() async {
    List<AdhyayListItem> l = [
      AdhyayListItem("title", 0),
      AdhyayListItem("tss", 1)
    ];
    const url = "https://sellershopapp-default-rtdb.firebaseio.com/Adhyay.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      final data = json.decode(response.body) as Map<String, dynamic>;
      _adhyays.clear();
      ads.clear();
      print("response : --- " + data.toString());
      // print("Data is "+data["-Mm7AHxmjXNZww9e75sA"]);
      data.forEach((prodId, prod) {
        _adhyays.add(Adhyay(
            story: prod['story'].toString(), title: prod['title'].toString()));
        addAdhyay(Adhyay(title: "title", story: "st"));
        ads.add(AdhyayListItem(prod['title'].toString(), 6));
        print("Id  : " + prodId);
        print("Body " + prod['title'].toString());
        // print("Prod ID : " + prod[0]);
      });
      print("Items size is  : " + ads.length.toString());

      notifyListeners();
    } catch (error) {
      notifyListeners();
      rethrow;
    }
  }

  Future<void> getAndSetAllItems() async {
    const url =
        "https://sellershopapp-default-rtdb.firebaseio.com/Anubhutis.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      final data = json.decode(response.body) as Map<String, dynamic>;
      _items.clear();
      final List<ListItemModel> itemsFromDatabase = [];
      print("response : --- " + data.toString());
      // print("Data is "+data["-Mm7AHxmjXNZww9e75sA"]);
      data.forEach((prodId, prod) {
        _items.add(ListItemModel(
            id: prodId,
            anubhutiId: prod['anubhutiId'].toString(),
            title: prod['title'].toString(),
            isUpdated: true));

        print("Id  : " + prodId);
        print("Body " + prod['anubhavId'].toString());
        // print("Prod ID : " + prod[0]);
      });
      print("Items size is  : " + _items.length.toString());
      notifyListeners();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> getAndSetSampleItems(String selectedYearMonth) async {
    const url =
        "https://sellershopapp-default-rtdb.firebaseio.com/Sample_Anubhutis.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      final data = json.decode(response.body) as Map<String, dynamic>;
      _sampleItems.clear();
      print("response : --- " + data.toString());
      // print("Data is "+data["-Mm7AHxmjXNZww9e75sA"]);
      data.forEach((prodId, prod) {
        if (prod['anubhutiId'].toString() == selectedYearMonth) {
          _sampleItems.add(ListItemModel(
              id: prodId,
              anubhutiId: prod['anubhutiId'].toString(),
              title: prod['title'].toString(),
              isUpdated: prod['isUpdated']));
        } else {}
        print("Id  : " + prodId);
        print("Body " + prod['anubhavId'].toString());
        // print("Prod ID : " + prod[0]);
      });
      print("Items size is  : " + _sampleItems.length.toString());
      notifyListeners();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> getAndSetAllSampleItems() async {
    const url =
        "https://sellershopapp-default-rtdb.firebaseio.com/Sample_Anubhutis.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      final data = json.decode(response.body) as Map<String, dynamic>;
      _sampleItems.clear();
      print("response : --- " + data.toString());
      // print("Data is "+data["-Mm7AHxmjXNZww9e75sA"]);
      data.forEach((prodId, prod) {
        _sampleItems.add(ListItemModel(
            id: prodId,
            anubhutiId: prod['anubhutiId'].toString(),
            title: prod['title'].toString(),
            isUpdated: prod['isUpdated']));

        print("Id  : " + prodId);
        print("Body " + prod['anubhavId'].toString());
        // print("Prod ID : " + prod[0]);
      });
      print("Items size is  : " + _sampleItems.length.toString());
      notifyListeners();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  void deleteItem() {
    getAndSetAllItems();
    notifyListeners();
  }
}
