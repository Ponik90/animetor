import 'package:animetor_app/screen/home/model/home_model.dart';
import 'package:animetor_app/utils/json_helper.dart';
import 'package:animetor_app/utils/shared_helper.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  List<HomeModel> planetList = [];
  SharedHelper helper = SharedHelper();
  List<String> bookmark = [];
  List<String> bookmarkName = [];
  bool isTheme = true;

  Future<void> changeTheme() async {
    isTheme = await helper.getTheme();
    notifyListeners();
  }

  Future<void> setBookMarkData(String img, String pname) async {
    List<String>? data = await helper.getPlanet();
    List<String>? name = await helper.getName();

    if (data != null && name != null) {
      name.add(pname);
      data.add(img);
      helper.setPlanet(data);
      helper.setName(name);
    } else {
      helper.setPlanet([img]);
      helper.setName([pname]);
    }
    getBookmark();
    notifyListeners();
  }

  Future<void> getBookmark() async {
    var plist = await helper.getPlanet();
    var nlist = await helper.getName();
    if (plist != null && nlist != null) {
      bookmark = plist;
      bookmarkName = nlist;
      notifyListeners();
    }
  }

  void deleteBookmark(int index) {

    bookmark.removeAt(index);
    bookmarkName.removeAt(index);
    helper.setPlanet(bookmark);
    helper.setName(bookmarkName);
    notifyListeners();
  }

  Future<void> getJsonData() async {
    JsonHelper helper = JsonHelper();
    planetList = await helper.planetJson();
    notifyListeners();
  }
}
