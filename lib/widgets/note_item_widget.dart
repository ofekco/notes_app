
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/modeles/note.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/screens/note_edit_screen.dart';

class NoteItem extends StatelessWidget {
  final Map<String, dynamic> firestoreNote;

  const NoteItem({Key? key, required this.firestoreNote}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final Timestamp dateAsTimestemp = firestoreNote['date'];

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
              offset: const Offset(4, 4),
              blurRadius: 16,
            ),
          ],
        ),
        padding: const EdgeInsets.only(left: 16, top: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              onTap: () {
                Navigator.push(context,             
                MaterialPageRoute(builder: ((context) => 
                  NoteEditScreen(Note(firestoreNote['id'], firestoreNote['title'], firestoreNote['body'], dateAsTimestemp.toDate() , firestoreNote['latitude'], firestoreNote['longitude'])))));
              },
              title: Text(
                firestoreNote['title'],
                style: const TextStyle(
                  fontSize: 26,
                  color: Color(0xFF444444),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  DateFormat().format(dateAsTimestemp.toDate()),
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xFF444444).withOpacity(.4),
                  ),
                ),
              ),
          
      )],
    ),
    ), );
  }
}