import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/widgets/note_item_widget.dart';
import 'package:intl/intl.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('notes')
            .orderBy('date')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final notes = streamSnapshot.data?.docs;
          if(notes == null || notes.isEmpty) {
            return const Center(
              child: Text('You don\'t have any notes yet',
                style: TextStyle(
                color: Color(0xFF444444),
                fontSize: 20.0,
              ),),
            );
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(8),
              child: NoteItem(firestoreNote: notes[index].data()),
            ),
          );
        },
      ),
      );
      
  }
}