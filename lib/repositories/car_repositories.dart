import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firebase_service.dart';

class CarRepository{

  //Function to get all of the data from car collection

  Stream<QuerySnapshot<Map<String, dynamic>>> showCars(){

    return FirebaseService
        .db.collection("cars")
        .snapshots();

  }


}