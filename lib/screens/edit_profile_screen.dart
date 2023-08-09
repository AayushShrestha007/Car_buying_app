import 'package:car_buying_app/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:provider/provider.dart';


class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  File? _selectedImage;

  late AuthViewModel _authViewModel;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();



  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  //Function for changing password
  void changePassword(String password, String id) async {
    try {
      if (password == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please Fill Password")),
        );
      } else {
        await _authViewModel.changePassword(password, id);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password too short, please enter a longer password")),
      );
    }
  }

  //Function for changing Name
  void changeName(String name, String id) async {
    try {
      if (name == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please Fill Name")),
        );
      } else {
        await _authViewModel.changeName(name, id);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unknown error occured")),
      );
    }
  }

  //function for changing Profile Picture
  Future<void> changeProfilePicture() async {
    if (_selectedImage != null) {
      // Upload image to Firebase Storage and get the URL
      String? imageUrl = await _authViewModel.uploadProfileImage(_selectedImage!);

      if (imageUrl != null) {
        // Update the image URL in the user model
        if (_authViewModel.loggedInUser != null) {
          // _authViewModel.loggedInUser!.imageURL = imageUrl;

          await _authViewModel.changeProfilePicture(imageUrl, _authViewModel!.loggedInUser!.id!);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload profile image")),
        );
      }
    }
  }

  //Function for logging out

  void logout() async {
    try {
      _authViewModel.logout();
      Navigator.of(context).pushNamed("/login");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unknown error occured")),
      );
    }
  }

  @override
  void initState() {
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    _passwordController.text = _authViewModel.loggedInUser?.password ?? '';
    _nameController.text = _authViewModel.loggedInUser?.name ?? '';
    _emailController.text = _authViewModel.loggedInUser?.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd0d8df),


      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFd0d8df),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Profile",
        style: TextStyle(
          color: Colors.black,
        ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 13, right: 20),
            child: Consumer<AuthViewModel>(
              builder: (context, _authViewModel, child) =>
              InkWell(
                onTap: (){
                  changePassword(_passwordController.text, _authViewModel.loggedInUser?.id ?? '');
                  changeName(_nameController.text, _authViewModel.loggedInUser?.id ?? '');
                  changeProfilePicture();

                },
                child: Text(
                    "Confirm",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _selectImage();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 89,
                  child: CircleAvatar(
                    radius: 87,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: (_selectedImage != null)
                          ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      )
                          : Image.network(
                        _authViewModel.loggedInUser?.imageURL ?? "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png",
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(right: 220),
                child: Text("Email Address",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              SizedBox(
                height: 8,
              ),

              TextFormField(
                enabled: false,
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),


              Padding(
                padding: const EdgeInsets.only(right: 250),
                child: Text("Full Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                height: 8,
              ),

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.only(right: 250),
                child: Text("Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                height: 8,
              ),

              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 65,
                width: 350,
                child: Consumer<AuthViewModel>(
                    builder: (context, _authViewModel, child) =>
                  ElevatedButton(
                    onPressed: () {
                      logout();
                    },
                    style: ElevatedButton.styleFrom(

                      primary: Color(0xFF1f2959),
                      elevation: 3,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),





    );
  }
}
