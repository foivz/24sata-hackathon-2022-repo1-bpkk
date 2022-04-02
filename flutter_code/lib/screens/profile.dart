import 'package:flutter/material.dart';
import 'package:flutter_code/screens/chart_prediction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../custom_colors.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'chart_history_screen.dart';


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
      body: Column(
        children: [
          SizedBox(height: 64,),
          Container(
              alignment: Alignment.center,
              child: Text("Boris Španić", style: GoogleFonts.quicksand(fontSize: 40, fontWeight: FontWeight.w800),),
              width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: 32,),
          Container(
            margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 218,
                    height: 64,
                    child:
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(CustomColor().mainColor),
                      ),
                      onPressed: () {
                        return;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Digitalni novčanik", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w800),),
                          Icon(
                            Icons.account_balance_wallet_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
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
                ],
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => PredictionChart()));
          }
        }),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.receipt_outlined),
            title: Text("Troškovi"),
            selectedColor: CustomColor().mainColor,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.analytics_outlined,),
            title: Text("Potrošnja"),
            selectedColor: CustomColor().mainColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.insights_outlined),
            title: Text("Predikcija"),
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