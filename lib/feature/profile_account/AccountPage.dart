import 'package:flutix_app/feature/profile_account/EditProfilePage.dart';
import 'package:flutix_app/feature/splash_screen/view/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/HistoryTransactions.dart';
import '../../model/User.dart';
import '../my_wallet/MyWalletPage.dart';

class AccountPage extends StatefulWidget {
  final User user;
  final double saldo;
  final List<HistoryTransactions>? history;
  const AccountPage({Key? key, required this.user, required this.saldo, this.history}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<HistoryTransactions> _history = [];
  @override
  void initState() {
    if(widget.history != null){
      widget.history!.forEach((element) {
        _history.add(element);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    removeData() async{
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('name');
      prefs.remove('email');
      prefs.remove('password');
      prefs.remove('saldo');
      prefs.remove('historyTrn');
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        iconTheme: IconThemeData(
          color: Color(0XFF262626),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
           children: [
             Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   widget.user.photoProfile != null ?
                   CircleAvatar(backgroundImage: FileImage( widget.user.photoProfile!), radius: 25.0,)
                       :
                   Image.asset(
                     'assets/user.png', 
                     height: 130,
                   ),
                   SizedBox(height: 16,),
                   Text('${widget.user.name}', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                   SizedBox(height: 8,),
                   Text('${widget.user.email}', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 16),),
                 ],
               ),
             ),
             SizedBox(height: 24,),
             Column(
               children: [
                 InkWell(
                   onTap: ()async{
                     var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfilePage(user: widget.user)));
                     if(result != null){
                       setState(() {
                         widget.user.photoProfile = result;
                       });
                     }
                   },
                   child: Row(
                     children: [
                       SvgPicture.asset('assets/user.svg',height: 22,),
                       SizedBox(width: 16,),
                       Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
                     ],
                   ),
                 ),
                 SizedBox(height: 16,),
                 MySeparator(),
                 SizedBox(height: 16,),
                 InkWell(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWalletPage(user: widget.user, saldo: widget.saldo,historyTransactions: _history,)));
                   },
                   child: Row(
                     children: [
                       SvgPicture.asset('assets/wallet.svg',height: 22,),
                       SizedBox(width: 16,),
                       Text('My Wallet', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
                     ],
                   ),
                 ),
                 SizedBox(height: 16,),
                 MySeparator(),
                 SizedBox(height: 16,),
                 InkWell(
                   onTap: (){},
                   child: Row(
                     children: [
                       SvgPicture.asset('assets/translate.svg',height: 22,),
                       SizedBox(width: 16,),
                       Text('Change Language', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
                     ],
                   ),
                 ),
                 SizedBox(height: 16,),
                 MySeparator(),
                 SizedBox(height: 16,),
                 InkWell(
                   onTap: (){},
                   child: Row(
                     children: [
                       SvgPicture.asset('assets/helpCentre.svg',height: 22,),
                       SizedBox(width: 16,),
                       Text('Help Centre', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
                     ],
                   ),
                 ),
                 SizedBox(height: 16,),
                 MySeparator(),
                 SizedBox(height: 16,),
                 InkWell(
                   onTap: (){},
                   child: Row(
                     children: [
                       SvgPicture.asset('assets/like.svg',height: 22,),
                       SizedBox(width: 16,),
                       Text('Rate Flutix App', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
                     ],
                   ),
                 ),
                 SizedBox(height: 16,),
                 MySeparator(),
                 SizedBox(height: 16,),
                 InkWell(
                   onTap: (){
                     removeData();
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SplashScreen()), (route) => false);
                   },
                   child: Row(
                     children: [
                       SvgPicture.asset('assets/logout.svg',height: 22,),
                       SizedBox(width: 16,),
                       Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
                     ],
                   ),
                 ),
                 SizedBox(height: 16,),
                 MySeparator(),
               ],
             )
           ],
          ),
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1})
      : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey[400]),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}