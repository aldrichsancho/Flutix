import 'dart:core';
import 'dart:io';

import 'package:flutix_app/feature/splash_screen/view/ConfirmNewAccountPage.dart';
import 'package:flutix_app/model/TypeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/User.dart';

class SelectFavGenresPage extends StatefulWidget {
  final User? userData; //untuk passing data user
  const SelectFavGenresPage({Key? key, this.userData}) : super(key: key);

  @override
  State<SelectFavGenresPage> createState() => _SelectFavGenresPageState();
}

class _SelectFavGenresPageState extends State<SelectFavGenresPage> {
  List<TypeModel> genres = [
    TypeModel(title: 'Horror', isSelected: false),
    TypeModel(title: 'Music', isSelected: false),
    TypeModel(title: 'Action', isSelected: false),
    TypeModel(title: 'Drama', isSelected: false),
    TypeModel(title: 'War', isSelected: false),
    TypeModel(title: 'Crime', isSelected: false),
  ];

  List<TypeModel> languages = [
    TypeModel(title: 'Bahasa', isSelected: false),
    TypeModel(title: 'English', isSelected: true),
    TypeModel(title: 'Japanese', isSelected: false),
    TypeModel(title: 'Korean', isSelected: false)
  ];

  int selectedGenreTotal = 0;

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20,0,20,20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Your Four \nFavorite Genre', style: TextStyle(color: Color(0XFF262626), fontSize: 22, fontWeight: FontWeight.w300),),
              SizedBox(height: 20),
              GridView.count( // sebenenarnya bisa pakai looping for biasa, tapi diflutter lebih afdol pakai gridview
                shrinkWrap: true,
                childAspectRatio: 3,
                crossAxisCount: 2, // berapa banyak kolomnya
                mainAxisSpacing: 25, //jarak baris
                crossAxisSpacing: 25, //jarak kolom
                children: List.generate(genres.length, (i) {
                  return InkWell(
                    onTap: (){
                        if(selectedGenreTotal < 4){ //cek genre sudah dipilih sebanyak 4?
                          genres[i].isSelected = !genres[i].isSelected; //kalau belum maka nilai jadi true (!false jadi true) -- ini dibuat ada ! agar genre yang telah terpilih jika diklik maka akan kembali normal (false)
                          if(genres[i].isSelected == true){ //jika terpilih maka coutner tambah 1 jika tidak minus 1
                            selectedGenreTotal += 1;
                          }
                          else{
                            selectedGenreTotal -= 1;

                          }
                        }
                        else{ //kalau sudah 4 genre yang terpilih, maka tidak bisa pilih jadi nilainya dipastikan false dan counter minus 1
                          genres[i].isSelected = false;
                          selectedGenreTotal -= 1;
                        }

                        if(selectedGenreTotal < 0){ //perlu dicek buat jaga" siapa tau nilai counter < 0
                          selectedGenreTotal = 0;
                        }

                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: genres[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: genres[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                      ),
                      child: Center(child: Text('${genres[i].title}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w300, fontSize: 16),)),
                    ),
                  );
                })
              ),
              SizedBox(height: 20),
              Text('Movie Language \nYou Prefer?', style: TextStyle(color: Color(0XFF262626), fontSize: 22, fontWeight: FontWeight.w300),),
              SizedBox(height: 20),
              GridView.count( // sebenenarnya bisa pakai looping for biasa, tapi diflutter lebih afdol pakai gridview
                  shrinkWrap: true,
                  childAspectRatio: 3,
                  crossAxisCount: 2,
                  mainAxisSpacing: 25, //jarak baris
                  crossAxisSpacing: 25, //jarak kolom
                  children: List.generate(languages.length, (i) {
                    return InkWell(
                      onTap: (){
                        //berbeda dengan genre, language hanya bisa terpilih 1
                        //konsep : ubah semua isSelected languages jadi false dan isi language yang terpilih jadi true
                        for(var j = 0; j < languages.length; j++){
                          languages[j].isSelected = false;
                        }
                        languages[i].isSelected = true; //ini diassign true dan tidak ada ! karena dicontoh flutix jika yg udah keselect dipencet maka tidak akan hilang
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: languages[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: languages[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                        ),
                        child: Center(child: Text('${languages[i].title}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w300, fontSize: 16),)),
                      ),
                    );
                  })
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      bool next = false;
                      int totalSelectedGenres = 0;
                      for(var i = 0; i<genres.length; i++){
                        if(genres[i].isSelected){
                          totalSelectedGenres += 1;
                        }
                      }
                      if(totalSelectedGenres == 4){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmNewAccountPage(userData: widget.userData)));
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please select 4 genres'),
                          elevation: 0,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0XFFFE5981),
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 78),
                        ));
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
