import 'package:flutter/material.dart';
import 'package:noteapp/constant/color.dart';
import 'package:noteapp/service/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteapp/service/notemodel.dart';

class DisplayNotesScreen extends StatefulWidget {
  const DisplayNotesScreen({super.key});

  @override
  State<DisplayNotesScreen> createState() => _DisplayNotesScreenState();
}

class _DisplayNotesScreenState extends State<DisplayNotesScreen> {
  final FirestoreDataSource _firestoreDataSource = FirestoreDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        automaticallyImplyLeading: false,
        title: Text(
          "Notes",
          style: TextStyle(
            color: textcolor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreDataSource.stream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final notes = _firestoreDataSource.getNotes(snapshot);

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                color: buttoncolor,
                child: ListTile(
                  title: Text(
                    note.title,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.description,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        note.time,
                        style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 83, 44, 223)),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _showEditDialog(note);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _firestoreDataSource.deleteNote(note.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showEditDialog(Note note) {
    final titleController = TextEditingController(text: note.title);
    final descriptionController = TextEditingController(text: note.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                maxLines: 2,
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _firestoreDataSource.updateNote(
                  note.id,
                  titleController.text,
                  descriptionController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
