import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ConfirmNewAccountPage extends StatefulWidget {
  final List? userData; //untuk passing data user
  const ConfirmNewAccountPage({Key? key, this.userData}) : super(key: key);

  @override
  State<ConfirmNewAccountPage> createState() => _ConfirmNewAccountPageState();
}

class _ConfirmNewAccountPageState extends State<ConfirmNewAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        centerTitle: true, //buat tulisan title ke tengah(confirm new account)
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0XFF262626),
        ),
        title: Text('Confirm \nNew Account', style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400), textAlign: TextAlign.center,), //textAlign disini mirip sama yg di mic.word
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.height - 200,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              children: [
                SizedBox(height: 20,),
                widget.userData![0] != null ? //isi userData ke 0 = foto, yg ke 1 = datalogin ==> lihat di signUp.dart line 193
                CircleAvatar(backgroundImage: FileImage( widget.userData![0]), radius: 80.0,)
                    :
                Image.asset(
                  'assets/user.png',
                  height: 120,
                ),
                SizedBox(height: 20,),
                Text('Welcome', style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w300, fontSize: 16)),
                SizedBox(height: 4,),
                Text('${widget.userData![1].name}', style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 20)),
                SizedBox(height: 120,),
                RawMaterialButton(
                  onPressed: (){
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width, minHeight: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  fillColor: Colors.teal,
                  child: Text('Create My Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
