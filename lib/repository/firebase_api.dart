import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/movie.dart';
import '../models/user.dart' as UserApp;

class FirebaseApi {

  Future<String?> createUser(String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  Future<String?> signInUser(String emailAddress, String password) async {
    try {
      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  Future<String> createUserInDB(UserApp.User user) async{
    try{
      var db = FirebaseFirestore.instance;
      final document = await db.collection('users').doc(user.uid).set(user.toJson());
      return user.uid;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  Future<String> createMovie(Movie movie, File? image) async{
    try{
      final uid = FirebaseAuth.instance.currentUser?.uid;
      var db = FirebaseFirestore.instance;
      final document = await db
          .collection('users')
          .doc(uid)
          .collection('movies')
          .doc();
      movie.id = document.id;

      final storageRef = FirebaseStorage.instance.ref();
      final moviePictureRef = storageRef.child('movies').child("${movie.id}.jpg");
      await moviePictureRef.putFile(image!);
      movie.urlPicture = await moviePictureRef.getDownloadURL();

      await db
        .collection('users')
        .doc(uid)
        .collection('movies')
        .doc(document.id)
        .set(movie.toJson());

      await db
          .collection('movies')
          .doc(document.id)
          .set(movie.toJson());

      return document.id;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  Future<String> deleteMovie(QueryDocumentSnapshot movie) async{
    try{
      final uid = FirebaseAuth.instance.currentUser?.uid;

      await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('movies')
      .doc(movie.id)
      .delete();

      await FirebaseFirestore.instance
          .collection('movies')
          .doc(movie.id)
          .delete();

      return uid!;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

}
