
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/widgets/note_widget.dart';


class User with ChangeNotifier{
  final String userId;
  final List<NoteItem> _userNotes = [];

  User({required this.userId}); 

  List<NoteItem> get UserNotes {
    return _userNotes;
  }

  void getUserNotesFromDB() {
      
  }

}