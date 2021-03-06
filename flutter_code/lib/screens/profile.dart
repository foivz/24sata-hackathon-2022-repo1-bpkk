import 'package:flutter/material.dart';
import 'package:flutter_code/screens/chart_prediction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../custom_colors.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

import 'ad.dart';
import 'chart_history_screen.dart';
import 'wishlist_screen.dart';
import 'digital_wallet.dart';

double vodaToken = 0.0;

class Profile extends StatefulWidget {

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {

  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w600 ),),
        backgroundColor: CustomColor().mainColor,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-64,
            child: FittedBox(
              fit: BoxFit.fill,
              child: ClipRect(
                child: Image.asset('images/wallpaper.png'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 40, 16, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    alignment: Alignment.center,
                    child: Text("David Vodopija", style: GoogleFonts.quicksand(fontSize: 40, fontWeight: FontWeight.w800,),),
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 128+64,
                          height: 48,
                          child:
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(CustomColor().mainColor),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DigitalWalletPage()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Digitalni nov??anik", style: GoogleFonts.quicksand(fontSize: 15, fontWeight: FontWeight.w800),),
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 56,
                          child: ElevatedButton(
                            onPressed: () async {
                              await LaunchApp.openApp(
                                androidPackageName: 'hr.erstebank.george',
                              );
                            },
                            child:
                            //Container(
                            /*color: Color(0xff1164d5),
                    child: */
                            ClipRRect(
                              child:
                              Image.asset('images/george2.png', height: 48, width: 48,),

                              borderRadius: BorderRadius.circular(96),
                            ),
                            //),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(72, 72),
                              shape: CircleBorder(),
                              //shadowColor: Colors.blue,
                              primary: Color(0xff1164d5),
                              animationDuration: const Duration(milliseconds: 0),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 40, 16, 40),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                vodaToken+=0.005;
                                vodaToken = double.parse(vodaToken.toStringAsFixed(3));
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AdPage()));
                              });
                            },
                            child: Text("Voda token: $vodaToken", style: GoogleFonts.quicksand(fontSize: 30, fontWeight: FontWeight.w800,)),
                          ),
                        ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() {
          _currentIndex = i;

          if (_currentIndex == 0){
            Navigator.pop(context);
          }
          if (_currentIndex == 1){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryChart()));
          }
          else if (_currentIndex == 2){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Wishlist())).then((value) => setState(() {_currentIndex = 0;}));
          }
        }),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.receipt_outlined),
            title: Text("Tro??kovi"),
            selectedColor: CustomColor().mainColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.insights_outlined),
            title: Text("Predikcija"),
            selectedColor: CustomColor().mainColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.checklist_outlined),
            title: Text("Lista"),
            selectedColor: CustomColor().mainColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.account_circle_outlined),
            title: Text("Profil"),
            selectedColor: CustomColor().mainColor,
          ),
        ],
      ),
    );
  }
}