import 'package:fms_ditu/API/eventDetails.dart';
import 'package:fms_ditu/API/registration.dart';

class EventRecord {
  static final EventRecord _singleton = EventRecord._internal();
  static List<EventDetails> technicalEvent = [];
  static List<EventDetails> culturalEvent = [];
  static List<EventDetails> informalEvent = [];
  static List<EventDetails> debateEvent = [];
  static List<EventDetails> gamingEvent = [];
  static List<EventDetails> topEvent = [];
  static List<Registration> registeredEvents = [];
  static String name = "";
  static String email = "";
  static String gender = "";
  static String number = "";

  factory EventRecord() {
    return _singleton;
  }
  EventRecord._internal();
}
