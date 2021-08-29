import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:jobs_app/src/models/job.dart';

class FirebaseService {
  static signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FlutterError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw FlutterError('Wrong password provided for that user.');
      }
    }
  }

  static signUp(String fullName, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser
          .updateProfile(displayName: fullName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw FlutterError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw FlutterError('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static CollectionReference<Job> jobsDb() {
    return FirebaseFirestore.instance.collection('jobs').withConverter<Job>(
          fromFirestore: (snapshot, _) => Job.fromJson(snapshot.data()),
          toFirestore: (job, _) => job.toJson(),
        );
  }

  static Future<void> createJob(Job job) async {
    await jobsDb().add(job);
  }

  static Future<List<QueryDocumentSnapshot<Job>>> readJobs(String keywords) {
    if (keywords != null && keywords.isNotEmpty) {
      return jobsDb()
          .where("title", isEqualTo: keywords)
          .get()
          .then((value) => value.docs);
    }
    return jobsDb().get().then((value) => value.docs);
  }
}
