import 'dart:convert';

import 'package:animetor_app/screen/home/model/home_model.dart';
import 'package:flutter/services.dart';

class JsonHelper {
  Future<List<HomeModel>> planetJson() async {
    String planet = await rootBundle.loadString("assets/json/planet.json");
    List planetList = jsonDecode(planet);
    List<HomeModel> data =
        planetList.map((e) => HomeModel.mapToModel(e)).toList();
    return data;
  }
}
