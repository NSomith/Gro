
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/userModal.dart';

class UserService{
  String collections = "user";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> createUser(Map<String,dynamic> values)async{
    String id = values['id'];
    await _firestore.collection(collections).doc(id).set(values);
  }

  Future<void> udateUserData(Map<String,dynamic>values)async{
    String id = values['id'];
    await _firestore.collection(collections).doc(id).update(values);
  }

  Future<void> getUserById(String id)async{
    await _firestore.collection(collections).doc(id).get().then((value){
      if(value.data()==null){
        return null;
      }
      return UserModal.fromSnashot(value);
    });
  }
}