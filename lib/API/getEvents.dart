// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// Future getEvents() async{
//   var responseData;
//   print("HelloBruh");
//   responseData = await FirebaseFirestore.instance.collection("events").get();
//   print("HelloBruh2");
//   print("Decoded + ${responseData}");
//   return jsonDecode(responseData);
// }