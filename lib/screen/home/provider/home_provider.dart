import 'package:animetor_app/screen/home/model/home_model.dart';
import 'package:animetor_app/utils/json_helper.dart';
import 'package:animetor_app/utils/shared_helper.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  List<HomeModel> planetList = [];
  SharedHelper helper = SharedHelper();
  List<String> bookmark = [];

  Future<void> setBookMarkData(String value) async {
    List<String>? data = await helper.getPlanet();

    if (data != null) {
      data.add(value);
      helper.setPlanet(data);
    } else {
      helper.setPlanet([value]);
    }
    getBookmark();
    notifyListeners();
  }

  Future<void> getBookmark() async {
    var list = await helper.getPlanet();
    if (list != null) {
      bookmark = list;
      notifyListeners();
    }
  }

  Future<void> getJsonData() async {
    JsonHelper helper = JsonHelper();
    planetList = await helper.planetJson();
    notifyListeners();
  }
}
