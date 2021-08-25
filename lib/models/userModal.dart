import 'package:cloud_firestore/cloud_firestore.dart';

class UserModal{
  static const NUMBER = "number";
  static const ID = "id";

  var _number;
  var _id;

  String get number => _number;
  String get id=> _id;

  UserModal.fromSnashot(DocumentSnapshot snapshot){
    _number = snapshot['NUMBER'];
    _id = snapshot['ID'];
  }

}