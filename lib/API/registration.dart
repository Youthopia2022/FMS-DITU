import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration {
  final String teamLeader;
  final String teamName;
  final List teamMember;
  final String eventName;
  final String eventDate;
  final String time;

  Registration(this.teamLeader, this.teamName, this.teamMember, this.eventName, this.eventDate, this.time);

  registerInFirestore() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("Registered Event").doc("User personal").collection(uid).doc(eventName).set({
      "team leader" : teamLeader,
      "team name" : teamName,
      "team member" : teamMember,
      "event name" : eventName,
      "date" : eventDate,
      "time" : time
    });
  }

  globalRegisterInFirestore() {
    var timer = DateTime.now();
    FirebaseFirestore.instance.collection("Registered Event").doc("For judges").collection(eventName).doc(timer.toString()).set({
      "team leader" : teamLeader,
      "team name" : teamName,
      "team member" : teamMember,
      "event name" : eventName,
      "date" : eventDate,
      "time" : time
    });
  }
}