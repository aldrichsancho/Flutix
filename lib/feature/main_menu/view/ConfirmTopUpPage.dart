import 'package:flutix_app/feature/my_wallet/MyWalletPage.dart';
import 'package:flutix_app/model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/HistoryTransactions.dart';
import 'MainMenuPage.dart';

class ConfirmTopUpPage extends StatefulWidget {
  final User user;
  final double newSaldoTotal;
  final List<HistoryTransactions> newHistoryTransactions;
  const ConfirmTopUpPage({Key? key, required this.user, required this.newSaldoTotal, required this.newHistoryTransactions}) : super(key: key);

  @override
  State<ConfirmTopUpPage> createState() => _ConfirmTopUpPageState();
}

class _ConfirmTopUpPageState extends State<ConfirmTopUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/successTopUp.jpeg',
                height: 110,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 60,),
              Text('Emmm Yummy!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
              SizedBox(height: 20,),
              Text('You have successfully \ntop up the wallet',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
              SizedBox(height: 50,),
              RawMaterialButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWalletPage(user: widget.user, saldo: widget.newSaldoTotal, historyTransactions: widget.newHistoryTransactions,)));
                },
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width, minHeight: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                fillColor: Color(0XFF382A75),
                child: Text('My Wallet', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Discover new movie?', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 14)),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainMenuPage(user: widget.user, newSaldo: widget.newSaldoTotal,newHistoryTransactions: widget.newHistoryTransactions,)),(route) => false);
                    },
                    child: Text('Back to Home', style: TextStyle(color: Color(0XFF382A75), fontWeight: FontWeight.w300, fontSize: 14))
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
