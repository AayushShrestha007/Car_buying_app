import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../repositories/auth_repositories.dart';
import '../services/firebase_service.dart';
import 'dart:io';

class AuthViewModel with ChangeNotifier{

  User? _user = FirebaseService.firebaseAuth.currentUser;
  User? get user => _user;

  UserModel? _loggedInUser;
  UserModel? get loggedInUser => _loggedInUser;



  //View Model code for register
  Future<void> register(UserModel user) async {
    try {
      var response = await AuthRepository().register(user);
      _user = response!.user;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }



  //View Model code for login
  Future<void> login(String email, String password) async {
    try {
      var response = await AuthRepository().login(email, password);
      _user = response.user;
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
      notifyListeners();
    } catch (err) {
      // AuthRepository().logout();
      rethrow;
    }
  }

  //View Model code for changing password

  Future<void> changePassword(String password, String id) async {
    try {
      await AuthRepository().changePassword(password, id);
      _loggedInUser?.password = password;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  //View Model for changing name
  Future<void> changeName(String name, String id) async {
    try {
      await AuthRepository().changeName(name, id);
      _loggedInUser?.name = name;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  //View Model code for uploading profile picture
  Future<String?> uploadProfileImage(File image) async {
    try {
      String? imageUrl =
      await AuthRepository().uploadProfileImage(image, loggedInUser!);
      return imageUrl;
    } catch (err) {
      rethrow;
    }
  }


  //View Model code for changing profile picture
  Future<void> changeProfilePicture(String imageURL, String id) async {
    try {
      await AuthRepository().changeProfilePicture(imageURL, id);
      _loggedInUser?.imageURL = imageURL;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  //View model code for adding favorite;
  Future<void> addFavorite(String id, UserModel loggedInUser) async {
    try {

      _loggedInUser = await AuthRepository().addFavorite(id, loggedInUser);

      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  //view model code for logging out
  Future<void> logout() async {
    try {
      await AuthRepository().logout();
      _loggedInUser = null;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }



}