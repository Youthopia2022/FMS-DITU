import 'package:flutter/cupertino.dart';

class UserData{
  final String gender;
  final String name;
  final String id;
  final String phone;
  final int year;
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
}