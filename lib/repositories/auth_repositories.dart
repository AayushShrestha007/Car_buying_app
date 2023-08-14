

import 'dart:io';

import 'package:car_buying_app/repositories/car_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/user_model.dart';
import '../services/firebase_service.dart';

class AuthRepository{


  //Repo code for register
  CollectionReference<UserModel> userRef = FirebaseService.db.collection("users")
      .withConverter<UserModel>(
    fromFirestore: (snapshot, _) {
      return UserModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );

  Future<UserCredential?> register(UserModel user) async {
    try {
      final response = await userRef
          .where("email", isEqualTo: user.email!).get();
      if (response.size != 0) {
        throw Exception("A user with this email already exists");
      }

      UserCredential uc = await FirebaseService.firebaseAuth
          .createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

      user.uid = uc.user!.uid;

      await userRef.add(user).then((DocumentReference doc) async {
        await userRef.doc(doc.id).update({
          "id": doc.id,
        });
      });


      return uc;

    } catch (err) {
      rethrow;
    }
  }


  //Repo code for login
  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential uc = await FirebaseService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return uc;
    } catch (err) {
      rethrow;
    }
  }

  //getting user detail with Id
  Future<UserModel> getUserDetail(String uid) async {
    try {
      final response = await userRef.where("uid", isEqualTo: uid).get();
      var user = response.docs.single.data();
      await userRef.doc(user.id).set(user);
      return user;
    } catch (err) {
      rethrow;
    }
  }


  //Code to change password
  Future<bool> changePassword(String password, String id) async {
    try {

      userRef.doc(id).update({
        "password": password
      });

      await FirebaseService.firebaseAuth.currentUser!
          .updatePassword(password);
      return true;

    } catch (err) {
      print("Repo Err :: " + err.toString());
      rethrow;
    }
  }


  //Repo code for uploading image in firestore

  Future<String?> uploadProfileImage(File image, UserModel user) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      String imagePath = "profile_images/$imageName.jpg";
      TaskSnapshot snapshot = await FirebaseService
          .storageRef
          .child(imagePath)
          .putFile(image);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (err) {
      print("REPO ERR :: " + err.toString());
      rethrow;
    }
  }


  //Repo code for updatingProfilePicture
  Future<bool> changeProfilePicture(String imageURL, String id) async {
    try {

      userRef.doc(id).update({
        "imageURL": imageURL,
      });

      return true;
    } catch (err) {
      print("Repo Err :: " + err.toString());
      rethrow;
    }
  }



  //Repo code for changing Name
  Future<bool> changeName(String name, String id) async {
    try {

      userRef.doc(id).update({
        "name": name
      });

      return true;
    } catch (err) {
      print("Repo Err :: " + err.toString());
      rethrow;
    }
  }

  //Repo code for adding something to the favorite list
  Future<UserModel> addFavorite(String id, UserModel loggedInUser) async{

    String? userId= loggedInUser.id;

    try {
      final response = await CarRepository().carRef.where("id", isEqualTo: id).get();

      await userRef.doc(userId).update({
        "favorite": FieldValue.arrayUnion([response.docs.single.data().toJson()]),
      });

      final response2= await userRef.where("id", isEqualTo: userId).get();

      loggedInUser = response2.docs.single.data();

      return loggedInUser;
    } catch (err) {
      rethrow;
    }


  }

  //repo code for logging out
  Future<bool> logout() async{
    FirebaseService.firebaseAuth.signOut();
    return true;

  }

}