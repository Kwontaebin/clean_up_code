import 'package:shared_preferences/shared_preferences.dart';

const IP = "http://localhost:4000";

Future<SharedPreferences> prefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs;
}