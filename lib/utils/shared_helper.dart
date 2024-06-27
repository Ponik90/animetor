import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  Future<void> setPlanet(List<String> img) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setStringList('planetImg', img);
  }

  Future<List<String>?> getPlanet() async {
    List<String>? data = [];
    SharedPreferences shr = await SharedPreferences.getInstance();
    data = shr.getStringList('planetImg');
    return data;
  }
}
