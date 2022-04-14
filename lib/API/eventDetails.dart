import 'package:flutter/material.dart';

class EventDetails {
  final String name;
  final String venue;
  final String about;
  final String club;
  final String date;
  final double eventFeeDit;
  final double eventFeeNonDit;
  final String image;
  final bool isTopEvent;
  final double max;
  final double min;
  final String time;
  final String category;

  EventDetails(
      this.name,
      this.venue,
      this.about,
      this.club,
      this.date,
      this.eventFeeDit,
      this.eventFeeNonDit,
      this.image,
      this.isTopEvent,
      this.max,
      this.min,
      this.time,
      this.category);
}
