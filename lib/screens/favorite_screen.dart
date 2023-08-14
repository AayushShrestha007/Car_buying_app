import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/car_viewmodel.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

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

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text("Favorite Cars",
        style: TextStyle(
          color: Colors.black
        )),
        elevation: 0,
        backgroundColor: Color(0xFFd0d8df),
      ),
      body:
      Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height-120,
                child: Consumer<AuthViewModel>(
                  builder: (context, _authViewModel, child)=>
                  ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _authViewModel.loggedInUser!.favorite!.length,
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
                                            _authViewModel.loggedInUser!.favorite?[index]["imageURL"],
                                            width: 190,
                                            height: 120,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),

                                        Flexible(
                                          child: Text(_authViewModel.loggedInUser!.favorite?[index]["name"],
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
                                                Text(_authViewModel.loggedInUser!.favorite?[index]["seat"] + " Seat",
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
                                                Text(_authViewModel.loggedInUser!.favorite?[index]["speed"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),

                                              ],
                                            )

                                        ),
                                        //container to show favorite button
                                        // Container(
                                        //   width: 40,
                                        //   height: 40,
                                        //   alignment: Alignment.center,
                                        //   decoration: BoxDecoration(
                                        //     color: Color(0xFF1F2959),
                                        //     borderRadius: BorderRadius.all(Radius.circular(200)),
                                        //   ),
                                        //   child: IconButton(
                                        //     onPressed: () {
                                        //       addFavorite(data?[index]["id"], _authViewModel.loggedInUser!);
                                        //     },
                                        //     icon: Icon(
                                        //       Icons.favorite,
                                        //       color: Colors.white,
                                        //       size: 20,
                                        //     ),
                                        //
                                        //   ),
                                        //
                                        // )

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
                        ),
                )
              ),
            )

          ],
        ),


      ),

    );
  }
}
