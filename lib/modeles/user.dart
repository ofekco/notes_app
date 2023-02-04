import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/modeles/note.dart';

class User {
  final String _email;
  final String _userName;
  final String _id;
  final List<Note> _notes;

  User(this._userName, this._email, this._id, this._notes);

  String get Email {
    return _email;
  }

  String get UserName {
    return _userName;
  }

  String get Id {
    return _id;
  }

  List<Note> get NotesList {
    return _notes;
  }


   factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      data?['username'],
      data?['email'],
      data?['id'],
      data?['notes']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (_userName != null) "username": _userName,
      if (_email != null) "email": _email,
      if (_id != null) "id": _id,
      if (_notes != null) "notes": _notes,
    };
  }
}


