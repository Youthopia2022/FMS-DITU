import 'package:flutter/cupertino.dart';

class UserData {
  final String gender;
  final String name;
  final String id;
  final String phone;
  final String year;
  final String branch;
  final String college;
  final String email;

  const UserData({
    required this.gender,
    required this.name,
    required this.id,
    required this.phone,
    required this.year,
    required this.branch,
    required this.college,
    required this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        gender: json['gender'],
        name: json['name'],
        id: json['uid'], //set uid
        phone: json['phone'],
        year: json['year'],
        branch: json['branch'],
        college: json['college'],
        email: json['email']);
  }
}
