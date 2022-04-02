import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../custom_colors.dart';

class LoginPage extends StatefulWidget{

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor().mainColor,
        title: Text("Prijava", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w800),),
      ),
      body: Card(
        margin: EdgeInsets.fromLTRB(16, 128, 16, 0),
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
              width: MediaQuery.of(context).size.width - 32,
              child:  TextFormField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor().mainColor, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor().mainColor, width: 2),
                  ),
                  hintText: "E-mail",
                  helperMaxLines: 128,
                  hintStyle: GoogleFonts.quicksand(
                    textStyle: const TextStyle(fontSize:16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
              width: MediaQuery.of(context).size.width - 32,
              child:  TextFormField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor().mainColor, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColor().mainColor, width: 2),
                  ),
                  hintText: "Lozinka",
                  helperMaxLines: 128,
                  hintStyle: GoogleFonts.quicksand(
                    textStyle: const TextStyle(fontSize:16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton( //Ovaj button sluzi za register funkcije, ovo dolje je anonimna funkcija no mozes napraviti sam svoju funkciju i assignat ju dolje
                  onPressed: () async {

                  },
                  child: Text("Registracija", style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(fontSize:16, fontWeight: FontWeight.w800, color: Colors.white),
                  )),
                  style: ElevatedButton.styleFrom(
                      primary: CustomColor().mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                  ),
                ),
                ElevatedButton( //Ovaj button sluzi za register funkcije, ovo dolje je anonimna funkcija no mozes napraviti sam svoju funkciju i assignat ju dolje
                  onPressed: () async {

                  },
                  child: Text("Prijavi se", style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(fontSize:16, fontWeight: FontWeight.w800, color: Colors.white),
                  )),
                  style: ElevatedButton.styleFrom(
                      primary: CustomColor().mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 4),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {},
                child: Container(
                  width: 128+64,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 40, child: Image.asset("images/facebook_icon.png", fit: BoxFit.contain,),),
                      Text("Facebook Login", style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 4, 0, 8),
              child:ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {},
                child: Container(
                  width: 128+64,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 40, child: Image.asset("images/google_icon.png", fit: BoxFit.contain,),),
                      Text("Google Login", style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}