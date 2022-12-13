import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../model/HistoryTransactions.dart';
import '../../model/User.dart';
import '../main_menu/view/TopUpPage.dart';

class MyWalletPage extends StatefulWidget {
  final User user;
  final double saldo;
  final List<HistoryTransactions> historyTransactions;
  const MyWalletPage({Key? key, required this.user, required this.saldo, required this.historyTransactions}) : super(key: key);

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  String moneyFormat(double amount) {
    if (amount == null) return '0';
    return NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
        .format(amount);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0XFF262626),
        ),
        backgroundColor: Colors.white,
        title: Text('My Wallet', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24, color: Color(0XFF262626))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0XFF382A75)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0XFFFFF1CA)
                            ),
                          ),
                          SizedBox(width: 4,),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0XFFFBD45F)
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text('IDR ${moneyFormat(widget.saldo)}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 32),),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Card Holder', style: TextStyle(color: Color(0XFFEEE5FF),fontWeight: FontWeight.w400, fontSize: 10),),
                              Row(
                                children: [
                                  Text('Nama', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400, fontSize: 12),),
                                  SizedBox(width: 4,),
                                  SvgPicture.asset('assets/check.svg',height: 18,),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Card ID', style: TextStyle(color: Color(0XFFEEE5FF),fontWeight: FontWeight.w400, fontSize: 10),),
                              Row(
                                children: [
                                  Text('B9DEROALWT', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400, fontSize: 12),),
                                  SizedBox(width: 4,),
                                  SvgPicture.asset('assets/check.svg',height: 18,),
                                ],
                              ),

                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text('Recent Transaction', style: TextStyle(fontWeight: FontWeight.w300),),
              SizedBox(height: 16,),
              for(var i = 0; i<widget.historyTransactions.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0XFF382A75)
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Container(
                              height: 12,
                              width: 12,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0XFFFFF1CA)
                              ),
                            ),
                            SizedBox(width: 4,),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0XFFFBD45F)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.historyTransactions[i].name}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                        SizedBox(height: 6,),
                        Text('IDR ${moneyFormat(widget.historyTransactions[i].nominal!)}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.teal),),
                        SizedBox(height: 6,),
                        Text('${widget.historyTransactions[i].description}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0XFF382A75),
        elevation: 0,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TopUpPage(user: widget.user,saldo: widget.saldo,historyTransactions: widget.historyTransactions,)));
        //   if(result != null){
        //     setState(() {
        //       saldo += result;
        //     });
        //   }
        },
        label:Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text('Top Up My Wallet', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
        )

      ),
    );
  }
}
