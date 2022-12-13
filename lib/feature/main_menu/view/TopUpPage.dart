import 'package:flutix_app/feature/main_menu/view/ConfirmTopUpPage.dart';
import 'package:flutix_app/model/HistoryTransactions.dart';
import 'package:flutix_app/model/TopUpModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/User.dart';

class TopUpPage extends StatefulWidget {
  final User user;
  final double saldo;
  final List<HistoryTransactions> historyTransactions;
  const TopUpPage({Key? key, required this.user, required this.saldo, required this.historyTransactions}) : super(key: key);

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController nominalController = TextEditingController(text: 'IDR 0');
  String moneyFormat(double amount) {
    if (amount == null) return '0';
    return NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
        .format(amount);
  }

  List<TopUpModel> nominals = [
    TopUpModel(nominal: 50000, isSelected: false),
    TopUpModel(nominal: 100000, isSelected: false),
    TopUpModel(nominal: 150000, isSelected: false),
    TopUpModel(nominal: 200000, isSelected: false),
    TopUpModel(nominal: 250000, isSelected: false),
    TopUpModel(nominal: 500000, isSelected: false),
    TopUpModel(nominal: 1000000, isSelected: false),
    TopUpModel(nominal: 2500000, isSelected: false),
    TopUpModel(nominal: 5000000, isSelected: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
        color: Color(0XFF262626),
      ),
        backgroundColor: Colors.white,
        title: Text('Top Up', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24, color: Color(0XFF262626))),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                readOnly: true,
                controller: nominalController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                  ),
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Color(0XFF6F6F6F)),
                ),
              ),
              SizedBox(height: 20,),
              Text('Choose by Template', style: TextStyle(fontWeight: FontWeight.w300),),
              SizedBox(height: 10,),
              GridView.count( // sebenenarnya bisa pakai looping for biasa, tapi diflutter lebih afdol pakai gridview
                  shrinkWrap: true,
                  childAspectRatio: 1.5,
                  crossAxisCount: 3, // berapa banyak kolomnya
                  mainAxisSpacing: 16, //jarak baris
                  crossAxisSpacing: 16, //jarak kolom
                  children: List.generate(nominals.length, (i) {
                    return InkWell(
                      onTap: (){
                        for(var j = 0; j < nominals.length; j++){
                          nominals[j].isSelected = false;
                        }
                        nominals[i].isSelected = true;
                        nominalController.text = 'IDR ${moneyFormat(nominals[i].nominal!.toDouble())}';
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                          color: nominals[i].isSelected! ? Color(0XFFFBD45F) : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: nominals[i].isSelected! ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('IDR', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w300, fontSize: 16),),
                            SizedBox(height: 4,),
                            Text('${moneyFormat(nominals[i].nominal!.toDouble())}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 15),),
                          ],
                        ),
                      ),
                    );
                  })
              ),
              SizedBox(height: 60,),
              Center(
                child: RawMaterialButton(
                  onPressed: (){
                    double selectedNominal = 0;
                    for(var i = 0; i< nominals.length; i++){
                      if(nominals[i].isSelected!){
                        selectedNominal = nominals[i].nominal!.toDouble();
                      }
                    }
                    widget.historyTransactions.add(
                        HistoryTransactions(
                          name: "Top Up Wallet",
                          nominal: selectedNominal,
                          description: DateTime.now().toIso8601String(),
                          type: "topup"
                        )
                    );
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmTopUpPage(user: widget.user, newSaldoTotal: selectedNominal + widget.saldo, newHistoryTransactions: widget.historyTransactions,)));
                    // Navigator.pop(context, selectedNominal);
                  },
                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width *0.5, minHeight: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  fillColor: Colors.teal,
                  child: Text('Top Up My Wallet', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
