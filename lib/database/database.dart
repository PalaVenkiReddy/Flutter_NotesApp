import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';

class Database {
  // to initialise firebase instance
  late FirebaseFirestore firestore;
  initialise() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String title, String description) async {
    try {
      await firestore.collection("notes").add({
        'title': title,
        'description': description,
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("notes").doc(id).delete();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore.collection('notes').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "title": doc["title"],
            "description": doc["description"]
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    throw false;
  }

  Future<void> update(String id, String title, String description) async {
    try {
      await firestore
          .collection("notes")
          .doc(id)
          .update({'title': title, 'description': description});
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
