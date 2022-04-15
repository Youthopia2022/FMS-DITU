import 'package:fms_ditu/API/eventDetails.dart';

class EventRecord {
  static final EventRecord _singleton = EventRecord._internal();
  List<EventDetails> technicalEvent = [];
  List<EventDetails> culturalEvent = [];
  List<EventDetails> informalEvent = [];
  List<EventDetails> debateEvent = [];
  List<EventDetails> gamingEvent = [];
  List<EventDetails> topEvent = [];
  factory EventRecord() {
    return _singleton;
  }
  EventRecord._internal();
}
