import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/User.dart';
import 'SelectFavGenresPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FocusNode emailFocusNode = FocusNode(); //buat ngontrol warna label text email, biar ga Ungu terus
  FocusNode passwordFocusNode = FocusNode(); //buat ngontrol warna label text password, biar ga Ungu terus
  FocusNode confirmPasswordFocusNode = FocusNode(); //buat ngontrol warna label text confirm password, biar ga Ungu terus
  FocusNode nameFocusNode = FocusNode(); //buat ngontrol warna label text full name, biar ga Ungu terus

  TextEditingController emailController = TextEditingController(); //controller text email => biar program tau apa yang diinput user
  TextEditingController passwordController = TextEditingController(); //controller text password => biar program tau apa yang diinput user
  TextEditingController confirmPasswordController = TextEditingController(); //controller text confirm password => biar program tau apa yang diinput user
  TextEditingController nameController = TextEditingController(); //controller text full name => biar program tau apa yang diinput user

  bool validEmail = false;
  bool passwordLengthMoreThan5 = false;
  File? imageFile;

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0XFF262626),
        ),
        title: Text('Creating New \nAccount', style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,0,20,20),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none, alignment: Alignment.center,
                children : [
                  imageFile != null ?
                  CircleAvatar(backgroundImage: FileImage(imageFile!), radius: 45.0,):
                  Image.asset(
                    'assets/user.png',
                    height: 90,
                  ),
                  Positioned(
                    bottom: -15,
                    child: InkWell(
                      onTap: (){
                        if(imageFile != null){
                          setState(() {
                            imageFile = null;
                          });
                        }
                        else{
                          _getFromGallery();
                        }
                      },
                      child: imageFile != null ?
                      Image.asset(
                        'assets/remove.png',
                        height: 30,
                      ) :
                      Image.asset(
                        'assets/add.png',
                        height: 30,
                      ),
                    ),
                  ),
                ]
              ),
              SizedBox(height: 40,),
              TextFormField(
                controller: nameController,
                focusNode: nameFocusNode,
                onTap: (){
                  setState(() {
                    FocusScope.of(context).requestFocus(nameFocusNode);
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFF4F3E9C),width: 2),
                  ),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: nameFocusNode.hasFocus ? Color(0XFF4F3E9C) : Color(0XFF6F6F6F)),
                  hintText: 'Full Name',
                ),
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: emailController,
                focusNode: emailFocusNode,
                onTap: (){
                  setState(() {
                    FocusScope.of(context).requestFocus(emailFocusNode);
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFF4F3E9C),width: 2),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: emailFocusNode.hasFocus ? Color(0XFF4F3E9C) : Color(0XFF6F6F6F)),
                  hintText: 'Email',
                ),
              ),
              SizedBox(height: 16,),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                focusNode: passwordFocusNode,
                onTap: (){
                  setState(() {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFF4F3E9C),width: 2),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: passwordFocusNode.hasFocus ? Color(0XFF4F3E9C) : Color(0XFF6F6F6F)),
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 16,),
              TextFormField(
                obscureText: true,
                controller: confirmPasswordController,
                focusNode: confirmPasswordFocusNode,
                onTap: (){
                  setState(() {
                    FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFF4F3E9C),width: 2),
                  ),
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: confirmPasswordFocusNode.hasFocus ? Color(0XFF4F3E9C) : Color(0XFF6F6F6F)),
                  hintText: 'Confirm Password',
                ),
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      if(nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please fill all the fields'),
                          elevation: 0,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0XFFFE5981),
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 78),
                        ));
                      }
                      else if(passwordController.text != confirmPasswordController.text){
                        //cek kalau confirm password tidak sama dengan password
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Missmatch password and confirmed password'),
                          elevation: 0,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0XFFFE5981),
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 78),
                        ));
                      }
                      else if(!(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text))){
                        // cek kalau format email salah
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Wrong formatted email address'),
                          elevation: 0,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0XFFFE5981),
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 78),
                        ));
                      }
                      else if(passwordController.text == confirmPasswordController.text){
                        //cek panjang karakter password kalau confirm password sama dengan password
                        if(passwordController.text.length < 6){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Password's length min 6 characters"),
                            elevation: 0,
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Color(0XFFFE5981),
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 78),
                          ));
                        }
                        User user = new User(name: nameController.text, email: emailController.text, password: passwordController.text, photoProfile: imageFile);

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectFavGenresPage(userData:user)));
                      }
                      else{
                        User user = new User(name: nameController.text, email: emailController.text, password: passwordController.text, photoProfile: imageFile);

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectFavGenresPage(userData:user)));
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(0XFF4F3E9C),
                      minRadius: 25,
                      child: Icon(Icons.arrow_forward, color:Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
