import 'package:car_buying_app/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firebase_service.dart';

class CarRepository{

  CollectionReference<CarModel> carRef = FirebaseService.db.collection("cars")
      .withConverter<CarModel>(
    fromFirestore: (snapshot, _) {
      return CarModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );



  //Function to get all of the data from car collection

  Stream<QuerySnapshot<Map<String, dynamic>>> showCars(){

    return FirebaseService
        .db.collection("cars")
        .snapshots();
  }


}