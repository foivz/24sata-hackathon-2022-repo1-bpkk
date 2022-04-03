import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../custom_colors.dart';
import 'package:awesome_card/awesome_card.dart';
import '../widgets/custom_credit_card.dart';

class DigitalWalletPage extends StatefulWidget{

  @override
  _DigitalWalletPage createState() => _DigitalWalletPage();
}

class _DigitalWalletPage extends State<DigitalWalletPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Digitalni novčanik", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w600),),
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
          Column(
            children: [
              CustomCreditCard(
                cardNumber: "5450 5487 9847 7655",
                cardExpiry: "10/28", cvv: "456",
                cardHolderName: "David Vodopija",
                bank: "Erste Banka", expdate: "Exp. Date",
                textname: "Name", textExpiry: "MM/YY",
                showBack: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}