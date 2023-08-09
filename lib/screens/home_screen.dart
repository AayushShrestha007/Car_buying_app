import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late AuthViewModel _authViewModel;

  @override
  void initState() {
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    // _passwordController.text = _authViewModel.loggedInUser?.password ?? '';
    // _nameController.text = _authViewModel.loggedInUser?.name ?? '';
    // _emailController.text = _authViewModel.loggedInUser?.email ?? '';
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

            
          ],
        ),


      ),

    );
  }
}
