import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceData {

 static Future<void> setToken(String? token) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "$token" );
  }
 static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

 static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

 static Future<void> setIsFirstTime(bool? isFirstTime) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTime', isFirstTime??false );
  }
 static Future<bool?> getIsFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime');
  }

 static Future<void> removeIsFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('isFirstTime');
  }
  


}