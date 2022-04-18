import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration {
  final String teamLeader;
  final String teamName;
  final List teamMember;
  final String eventName;
  final String eventDate;
  final String time;
  final bool isPayed;
  final String timestamp;

  Registration(this.teamLeader, this.teamName, this.teamMember, this.eventName, this.eventDate, this.time, this.timestamp, this.isPayed);

  registerInFirestore() async{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("Registered Event").doc("User personal").collection(uid).doc(timestamp).set({
      "team leader" : teamLeader,
      "team name" : teamName,
      "team member" : teamMember,
      "event name" : eventName,
      "isPayed" : isPayed,
      "date" : eventDate,
      "time" : time,
      "timestamp" : timestamp
    });
  }

  globalRegisterInFirestore() async{
    await FirebaseFirestore.instance.collection("Registered Event").doc("For judges").collection(eventName).doc(timestamp).set({
      "team leader" : teamLeader,
      "team name" : teamName,
      "team member" : teamMember,
      "event name" : eventName,
      "date" : eventDate,
      "time" : time,
      "timestamp" : timestamp
    });
  }
}