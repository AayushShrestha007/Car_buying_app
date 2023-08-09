

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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



}