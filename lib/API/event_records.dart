import 'package:fms_ditu/API/eventDetails.dart';

class EventRecord {
  static final EventRecord _singleton = EventRecord._internal();
  static List<EventDetails> technicalEvent = [];
  static List<EventDetails> culturalEvent = [];
  static List<EventDetails> informalEvent = [];
  static List<EventDetails> debateEvent = [];
  static List<EventDetails> gamingEvent = [];
  static List<EventDetails> topEvent = [];
  static String name = "";
  static String email = "";
  static String gender = "";

  factory EventRecord() {
    return _singleton;
  }
  EventRecord._internal();
}
