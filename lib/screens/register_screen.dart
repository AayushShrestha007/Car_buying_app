import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../viewmodels/auth_viewmodel.dart';


class ValidateRegister{
  static String? emailValidate(String? value){
    if(value==null || value.isEmpty){
      return "Email is required";
    }
    return null;
  }

  static String? nameValidate(String? value){
    if(value==null || value.isEmpty){
      return "Email is required";
    }
    return null;
  }

  static String? passwordValidate(String? value){
    if(value==null || value.isEmpty){
      return "Password is required";
    }
    return null;
  }

  static String? confirmPassworddValidate(String? value){
    if(value==null || value.isEmpty){
      return "Password is required";
    }
    return null;
  }
}


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();


  late AuthViewModel _authViewModel;

  @override
  void initState() {
    // _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  void register() async {
    try {
      await _authViewModel.register(
          UserModel(
            email: _emailController.text,
            name: _nameController.text,
            password: _passwordController.text,
            favorite: [],
          )
      ).then((value) {

        Navigator.of(context).pushReplacementNamed("/login");
      })
          .catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())));
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(

            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/registerBackground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('''Best Car Deals
One Click Away''',
                      style: TextStyle(
                        fontSize: 38,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _nameController,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: '    Full Name',
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          )
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: '    Email Address',
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          )
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  TextFormField(
                    controller: _passwordController,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: '    Password',
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          )
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  TextFormField(
                    controller: _confirmPasswordController,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: '    Confirm Password',
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          )
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 55,
                    width: 600,
                    child: ElevatedButton(
                      onPressed: (){

                        if(_passwordController.text==_confirmPasswordController.text){
                          register();
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("The Password and confirmed password don't match"),
                            backgroundColor: Colors.red,),
                          );
                        }


                      },

                      child: Text("Register"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Color(0xFF1F2959),
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              color: Color(0xFFF4F900),
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed("/login");
                                // Handle sign in link tapped
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
