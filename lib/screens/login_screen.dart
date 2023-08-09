import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';




class ValidateLogin{
  static String? emailValidate(String? value){
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
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController _emailController= TextEditingController(
      text: "test@gmail.com"
  );
  TextEditingController _passwordController= TextEditingController(
      text: "123456"
  );


  late AuthViewModel _authViewModel;


  void initState(){
    _authViewModel= Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  void login(email, password) async{


    try{
      await _authViewModel.login(email,password)
          .then((value){

        Navigator.of(context).pushNamed('/homescreen');


      }).catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    } catch (err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
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
              image: AssetImage("assets/images/loginBackground.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('''Buy The Car 
of your dreams''',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),

                SizedBox(
                  height: 180,
                ),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: '    Email',
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
                  height: 20,
                ),

                SizedBox(
                  height: 55,
                  width: 600,
                  child: ElevatedButton(
                      onPressed: (){
                        login(_emailController.text, _passwordController.text);
                      },

                      child: Text("Log In"),
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
                      text: "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            color: Color(0xFFF4F900),
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed("/register");
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
