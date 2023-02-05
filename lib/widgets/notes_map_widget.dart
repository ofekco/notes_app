import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notes_app/modeles/note.dart';
import 'package:notes_app/screens/note_edit_screen.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;


  Map<Note, Marker> _createMarkers(List<QueryDocumentSnapshot<Map<String, dynamic>>> notes) {
    Map<Note, Marker> notesToMarkers = {};
    Timestamp dateAsTimestemp;

    notes.forEach((querySnapshot) {
      var noteMap = querySnapshot.data();
      dateAsTimestemp = noteMap['date'];
      var note = Note(noteMap['title'], noteMap['body'], dateAsTimestemp.toDate(), noteMap['latitude'], noteMap['longitude']);
      var marker = Marker(
        markerId: MarkerId(note.Title),
        position: LatLng(note.Latitude, note.Longitude),
        draggable: false,
        onTap: () => {
          Navigator.push(context,             
            MaterialPageRoute(builder: ((context) => 
              NoteEditScreen(Note(note.Title, note.Body, note.UpdateDate , note.Latitude, note.Longitude), false))))
        },
      );

      notesToMarkers[note] = marker;
    });
    
    return notesToMarkers;
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
            return const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(32.109333, 34.855499),
                zoom: 12,
              ),
            );
          }
          
          return GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(
                  notes.first.data()['latitude'],
                  notes.first.data()['longitude'],
                ),
                zoom: 12,
              ),
              markers: _createMarkers(notes).values.toSet(),
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
            );

  }
    );
  }
}