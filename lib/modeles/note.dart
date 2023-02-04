

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class Note {
  String _noteId;
  String _title;
  String _body;
  DateTime _lastUpdateDate;
  double _latitude;
  double _longitude;


  Note(this._noteId, this._title, this._body, this._lastUpdateDate, this._latitude, this._longitude);

  String get Id {
    return _noteId;
  }

  set Id (String id) {
    _noteId = id;
  }

  String get Title {
    return _title;
  }

  set Title (String title) {
    _title = title;
  }

  String get Body {
    return _body;
  }

  set Body (String body) {
    _body = body;
  }

  DateTime get UpdateDate {
    return _lastUpdateDate;
  }

  set UpdateDate (DateTime date) {
    _lastUpdateDate = date;
  }

  double get latitudeData {
    return _latitude;
  }

  set Latitude(double latitude) {
    _latitude = latitude;
  }

  double get Longitude {
    return _longitude;
  }

  set Longitude(double longitud) {
    _longitude = longitud;
  }


  factory Note.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Note(
      data?['title'],
      data?['body'],
      data?['date'],
      data?['id'],
      data?['latitude'],
      data?['longitude']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (_title != null) "title": _title,
      if (_body != null) "body": _body,
      if (_lastUpdateDate != null) "date": _lastUpdateDate,
      if (_latitude != null) "latitude": _latitude,
      if (_longitude != null) "longitude": _longitude,
      if (_noteId != null) "id": _noteId,
    };
  }
}