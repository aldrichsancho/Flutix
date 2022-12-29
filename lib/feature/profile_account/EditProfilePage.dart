import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../model/User.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  FocusNode emailFocusNode = FocusNode(); //buat ngontrol warna label text email, biar ga Ungu terus
  FocusNode passwordFocusNode = FocusNode(); //buat ngontrol warna label text password, biar ga Ungu terus
  FocusNode confirmPasswordFocusNode = FocusNode(); //buat ngontrol warna label text confirm password, biar ga Ungu terus
  FocusNode nameFocusNode = FocusNode(); //buat ngontrol warna label text full name, biar ga Ungu terus

  TextEditingController emailController = TextEditingController(); //controller text email => biar program tau apa yang diinput user
  TextEditingController userIdController = TextEditingController(); //controller text password => biar program tau apa yang diinput user
  TextEditingController confirmPasswordController = TextEditingController(); //controller text confirm password => biar program tau apa yang diinput user
  TextEditingController nameController = TextEditingController(); //controller text full name => biar program tau apa yang diinput user

  String tmpName = "";
  bool isUpdate = false;
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
  void initState() {
    emailController.text = widget.user.email;
    userIdController.text = 'BtYeiscnbhfdFSDIULowWQENV';
    nameController.text = widget.user.name;
    imageFile = widget.user.photoProfile;
    tmpName = nameController.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text('Edit Your \nProfile', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Color(0XFF262626)),textAlign: TextAlign.center,),
        ),
        iconTheme: IconThemeData(
          color: Color(0XFF262626),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,30,20,20),
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
                              isUpdate = true;
                            });
                          }
                          else{
                            _getFromGallery();
                            isUpdate = true;
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
                controller: userIdController,
                readOnly: true,
                style: TextStyle(color: Color(0XFFA1A1A1)) ,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                  ),
                  labelText: 'User Id',
                  labelStyle: TextStyle(color: Color(0XFFA1A1A1)),
                  hintText: 'user Id'
                ),
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: emailController,
                readOnly: true,
                style: TextStyle(color: Color(0XFFA1A1A1)) ,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                    ),
                    labelText: 'Email Address',
                    labelStyle: TextStyle(color: Color(0XFFA1A1A1)),
                    hintText: 'Email Address'
                ),
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: nameController,
                focusNode: nameFocusNode,
                onChanged: (newValue){
                  if(newValue != tmpName){
                      isUpdate = true;
                  }
                  else{
                    isUpdate = false;
                  }
                  setState(() {

                  });
                },
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
                    borderSide: BorderSide(color: Color(0XFFFBD361),width: 2),
                  ),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: nameFocusNode.hasFocus ? Color(0XFFFBD361) : Color(0XFF6F6F6F)),
                  hintText: 'Full Name',
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: RawMaterialButton(
                  onPressed: () async{ // pakai asing biar future delayed nya dijalanin dlu (nunggu 1 detik), setelahnya muncul tulisan the link to ...
                    await Future.delayed(Duration(seconds: 1, milliseconds: 500));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('The link to change your password has been sent to your email'),
                      elevation: 0,
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Color(0XFFFE5981),
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 90),
                    ));
                  },
                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width *0.6, minHeight: 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  fillColor: Colors.red,
                  child: Container(
                    width: MediaQuery.of(context).size.width *0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/warning.svg',height: 20,),
                          SizedBox(width: 8,),
                          Text('Change Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
                          SizedBox(width: 8,),
                          SvgPicture.asset('assets/warning.svg',height: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Center(
                child: RawMaterialButton(
                  onPressed: (){
                    if(isUpdate){
                      setState(() {
                        widget.user.photoProfile = imageFile;
                        widget.user.name = nameController.text;
                      });
                      Navigator.of(context).pop(imageFile);
                    }

                  },
                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width *0.6, minHeight: 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  fillColor: isUpdate ? Colors.teal : Colors.grey,
                  child: Text('Update My Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
