import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/modeles/note.dart';
import 'package:notes_app/widgets/my_title_textField.dart';
import 'package:location/location.dart';

class NoteEditScreen extends StatefulWidget {
  static const routeName = '/note_edit';
  final Note currentNote;

  const NoteEditScreen(this.currentNote, {super.key});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _notesCollection =  FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('notes');


  Note _editableNote = Note("0", "", "", DateTime.now(), 0, 0);
  String title = '';
  String body = '';
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();

  void handleTitleTextChange() {
        setState(() {
            title = _titleTextController.text.trim();
        });
    }

    void handleBodyChange() {
        setState(() {
            body = _bodyTextController.text.trim();
        });
    }

     @override
    void initState() {
        super.initState();
        _editableNote = widget.currentNote;
        _titleTextController.text = _editableNote.Title;
        _bodyTextController.text = _editableNote.Body;
        _titleTextController.addListener(handleTitleTextChange);
        _bodyTextController.addListener(handleBodyChange);
    }

    @override
    void dispose() {
        _titleTextController.dispose();
        _bodyTextController.dispose();
        super.dispose();
    }

    void _deleteNote() {
      if(_editableNote.Id != "0") {
       _notesCollection
        .where('id', isEqualTo: _editableNote.Id)
        .get()
        .then((snapshot) => snapshot.docs[0].reference.delete());
        
      }

      Navigator.pop(context); 
    }

    void _saveNote() async {
      _editableNote.Title = _titleTextController.text;
      _editableNote.Body = _bodyTextController.text;
      _editableNote.UpdateDate = DateTime.now();

      final location = await Location().getLocation();
      _editableNote.Latitude = location.latitude as double;
      _editableNote.Longitude = location.longitude as double;
      _editableNote.Id = (await _notesCollection.snapshots().length +1).toString();

      await _notesCollection.add(_editableNote.toFirestore()).then(
        (value) => {
          Navigator.pop(context)
        });
      
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF444444),
          ),
          tooltip: 'Back',
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: _saveNote,
            icon: const Icon(Icons.save_outlined, color: Color(0xFF444444),)),
          IconButton(
            onPressed: _deleteNote, 
            icon: const Icon(Icons.delete_outlined, color: Color(0xFF444444),)),
        ],
        title: MyTitleTextField(_titleTextController, _editableNote.Title),
      ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          height: MediaQuery.of(context).size.height,
          child: TextField(
            controller: _bodyTextController,
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            decoration: null,
            style: const TextStyle(
                fontSize: 19,
                height: 1.5,
              ),
            ),
          ),
        );

  }
}