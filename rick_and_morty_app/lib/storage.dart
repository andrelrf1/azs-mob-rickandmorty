// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocalStorage {
//   static Future<void> saveData(Map<String, dynamic> episode) async {
//     SharedPreferences storage = await SharedPreferences.getInstance();
//     await storage.setString('episodes', jsonEncode(episode));
//   }

//   static Future<Map<String, dynamic>> getData() async {
//     SharedPreferences storage = await SharedPreferences.getInstance();
//     String data = storage.getString('episodes');
//     if (data == null) {
//       return null;
//     } else {
//       return jsonDecode(data);
//     }
//   }

//   static Future<void> cleanData() async {
//     SharedPreferences storage = await SharedPreferences.getInstance();
//     await storage.clear();
//   }
// }
