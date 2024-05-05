import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class CacheHelper{
  static SharedPreferences ? sharedPreference;
  static init()async{
    sharedPreference=await SharedPreferences.getInstance();
  }
  static dynamic getData({required String key}){
    return sharedPreference!.get(key);
  }
  static Future<bool> saveData({required String key ,required dynamic value})async{
    if(value is String) return await sharedPreference!.setString(key, value);
    if(value is bool) return await sharedPreference!.setBool(key, value);
    if(value is int) return await sharedPreference!.setInt(key, value);
    return await sharedPreference!.setDouble(key, value);
  }
  static Future<bool> saveStringList({required String key ,required List <String> list})async{
    return await sharedPreference!.setStringList(key, list);
  }
}
Preferences preferences = Preferences();

var title = "Preferences";

class Preferences {

  static Preferences? _instance;

  Preferences._() {}

  factory Preferences() {
    if (_instance == null) {
      _instance = new Preferences._();
    }
    // since you are sure you will return non-null value, add '!' operator
    return _instance!;
  }

  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs!;

    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }


  Future<bool> saveBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  Future<bool> getBool(String key, bool defValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defValue;
  }


  Future<bool> saveString(String key, String value) async {
    final pref = await prefs;
    return pref.setString(key, value);
    ///////////// OR
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //return  prefs.setString(key, value);
  }

  Future<String> getString(String key, String defValue) async {
    final pref = await prefs;
    return pref.getString(key) ?? defValue;
    ///////////// OR
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //return prefs.getString(key) ?? defValue;
  }

  Future<bool> saveJson(String key, dynamic value) async {
    final pref = await prefs;
    return pref.setString(key, json.encode(value.toJson()));
    print(value.toString());
  }

  Future<dynamic> getJson(String key, dynamic defValue) async {
    final pref = await prefs;
    return json.decode(pref.getString(key)!) ?? defValue;
  }

  Future<bool> saveInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  Future<int> getInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? value;
  }

  Future<bool> saveDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  Future<double> getDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? value;
  }

  Future<bool> saveStringList(String key, List<String> value) async {
    final pref = await prefs;
    return pref.setStringList(key, value);
  }

  Future<List<String>> getStringList(String key, List<String> value) async {
    final pref = await prefs;
    return pref.getStringList(key) ?? value;
  }

  Future<bool> setMap(String tag, Map<String, dynamic> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(tag, jsonEncode(data));
  }

  Future<Map<String, dynamic>> getMap(String tag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return jsonDecode(sharedPreferences.getString(tag) ?? '{}');
  }

  Future<bool> setList(String tag, List<dynamic> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(tag, jsonEncode(data));
  }

  Future<List<dynamic>> getList(String tag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return jsonDecode(sharedPreferences.getString(tag) ?? '[]');
  }

  Future clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future removeValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  Future<bool> saveJsonList(String key, List<dynamic> value) async {
    return preferences.saveStringList(
        key, value.map((item) => json.encode(item)).toList());
  }

  Future<List<dynamic>> getJsonList(String key, List<dynamic> defValue) async {
    List<String> jsonStringList = await preferences.getStringList(key, []);
    return jsonStringList.map((jsonString) => json.decode(jsonString)).toList();
  }
}