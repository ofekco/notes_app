

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/modeles/note.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/screens/note_edit_screen.dart';

class NoteItem extends StatelessWidget {
  final Map<String, dynamic> DBnote;

  const NoteItem({Key? key, required this.DBnote}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final Timestamp _date = DBnote['date'];

    return GestureDetector(
      onTap: () {
        //navigate to note edit/view screem
      },
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
                  NoteEditScreen(Note(DBnote['id'], DBnote['title'], DBnote['body'], _date.toDate() , DBnote['latitude'], DBnote['longitude'])))));
              },
              title: Text(
                DBnote['title'],
                style: const TextStyle(
                  fontSize: 26,
                  color: Color(0xFF444444),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  DateFormat().format(_date.toDate()),
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF444444).withOpacity(.4),
                  ),
                ),
              ),
          
      )],
    ),
    ), );
  }
}