import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/service/notemodel.dart'; // Import your Note model
import 'package:uuid/uuid.dart';

class FirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(String email) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "id": _auth.currentUser!.uid,
        "email": email,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addNote(String description, String title) async {
    try {
      var uuid = Uuid().v4();
      DateTime date = DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({
        'id': uuid,
        'description': description,
        'isDone': false,
        'time': '${date.hour}:${date.minute}',
        'title': title,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

Future<bool> updateNote(String id, String title, String description) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(id)
          .update({
        'title': title,
        'description': description,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNote(String id) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  List<Note> getNotes(AsyncSnapshot<QuerySnapshot> snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'],
          data['description'],
          data['time'],
          data['title'],
        );
      }).toList();
      return notesList;
    } catch (e) {
      return [];
    }
  }

  Stream<QuerySnapshot> stream() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('notes')
        .snapshots();
  }
}
