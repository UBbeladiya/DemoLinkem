import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeData({required String userData}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Storing different types of data
  await prefs.setString('User',userData);

}

Future<void> getData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Retrieving data
  String? username = prefs.getString('User');

}

Future<void> removeData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Removing data by key
  await prefs.remove('User');  // Removes 'username' key
}
