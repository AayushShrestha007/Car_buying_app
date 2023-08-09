import 'package:car_buying_app/repositories/car_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CarViewModel with ChangeNotifier{

  Stream<QuerySnapshot<Map<String, dynamic>>>? _cars;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get cars=> _cars;


  Future<void> showCars() async {
    try{

      _cars = await CarRepository().showCars();
      notifyListeners();

    }catch(e){
      rethrow;

    }
  }


}