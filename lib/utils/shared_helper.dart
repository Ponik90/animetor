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
  Future<void> setName(List<String> name) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setStringList('planetName', name);
  }

  Future<List<String>?> getName() async {
    List<String>? data = [];
    SharedPreferences shr = await SharedPreferences.getInstance();
    data = shr.getStringList('planetName');
    return data;
  }

  Future<void> setTheme(bool value) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setBool('theme', value);
  }

  Future<bool> getTheme() async {
    bool? data;
    SharedPreferences shr = await SharedPreferences.getInstance();
    data = shr.getBool(
      'theme',
    )!;
    return data;
  }
}
