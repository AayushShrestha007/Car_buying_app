import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/car_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late AuthViewModel _authViewModel;
  late CarViewModel _carViewModel;

  @override
  void initState() {
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    _carViewModel= Provider.of<CarViewModel>(context, listen: false);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd0d8df),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Text("Available Cars",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  ),

                  SizedBox(
                    width: 110,
                  ),
                  ClipOval(
                    child: Image.network(
                      _authViewModel.loggedInUser?.imageURL ?? "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png",
                      fit: BoxFit.cover,
                      width: 70,
                      height: 70,
                    ),
                  ),

                ],
              ),
            ),

            StreamBuilder<QuerySnapshot>(
                stream: _carViewModel.cars,
                builder: (context, snapshot){
                  final data = snapshot.data?.docs;
                  final length = data?.length;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: length,
                      itemBuilder:(context, index){
                        return Container(

                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(
                            //   width: 10,
                            // ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: Image.network(
                                      "https://firebasestorage.googleapis.com/v0/b/car-buying-ddece.appspot.com/o/car_images%2Fimage%203-1.png?alt=media&token=4747c21f-52a3-4e51-9534-c1bf7b1823e6",
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 200,
                                    ),
                                  )
                                ],
                              )
                            ],

                          )


                        );
                      }
                  );
                }
            )

          ],
        ),


      ),

    );
  }
}
