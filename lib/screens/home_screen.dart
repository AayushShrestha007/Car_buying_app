import 'package:car_buying_app/models/user_model.dart';
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

  //function to add Favorite
  void addFavorite(id, UserModel loggedInUser) async{

    try{
      _authViewModel.addFavorite(id, loggedInUser);

    } catch (err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd0d8df),
      body:
      Padding(
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
                    width: 50,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    width: 60,
                    height: 60,
                    child: ClipOval(
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Color(0xFFFF9B9B),
                          size: 40,
                        ),

                        onPressed: (){
                          Navigator.pushNamed(context, "/favorite");
                        },
                      )
                    ),
                  ),

                  SizedBox(
                    width: 12,
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/editprofile");
                    },
                    child: ClipOval(
                      child: Image.network(
                        _authViewModel.loggedInUser?.imageURL ?? "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png",
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height-110,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _carViewModel.cars,
                    builder: (context, snapshot){
                      final data = snapshot.data?.docs;
                      final length = data?.length ?? 0;
                      print(length);
                      return ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: length,
                          itemBuilder:(context, index){
                            return Container(

                              height: 195,

                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        child: Image.network(
                                          data?[index]["imageURL"],
                                          width: 190,
                                          height: 120,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      
                                      Flexible(
                                        child: Text(data?[index]["name"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [

                                      //container to show seats
                                      Container(
                                          width: 100,
                                          height: 40,
                                          alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1F2959),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Icon(Icons.event_seat,
                                            color: Colors.white,
                                            size: 15),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(data?[index]["seat"] + " Seat",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),

                                          ],
                                        )

                                      ),

                                      SizedBox(
                                        width: 10,
                                      ),

                                      //Container to show speed
                                      Container(
                                          width: 100,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1F2959),
                                            borderRadius: BorderRadius.all(Radius.circular(30)),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 14,
                                              ),
                                              Icon(Icons.speed,
                                                  color: Colors.white,
                                                  size: 15),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(data?[index]["speed"],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),

                                            ],
                                          )

                                      ),

                                      SizedBox(
                                        width: 60,
                                      ),
                                      //container to show favorite button
                                      Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1F2959),
                                            borderRadius: BorderRadius.all(Radius.circular(200)),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              addFavorite(data?[index]["id"], _authViewModel.loggedInUser!);
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                              size: 20,
                                            ),

                                          ),

                                      )

                                    ],
                                  )
                                ],
                              )
                            );
                          },
                        separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 20,
                            );
                        },
                      );
                    }
                ),
              ),
            )

          ],
        ),


      ),

    );
  }
}
