import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../custom_colors.dart';
import 'package:awesome_card/awesome_card.dart';
import '../widgets/custom_credit_card.dart';
import 'package:flutter_code/http_requests.dart';

class DigitalWalletPage extends StatefulWidget{

  @override
  _DigitalWalletPage createState() => _DigitalWalletPage();
}

class _DigitalWalletPage extends State<DigitalWalletPage>{
  HTTPRequest hr = HTTPRequest();
  
  List<_Card> _cards = [];

  void initState(){
    super.initState();
    hr.getCards().then((c){
      var cards = c[1];
      setState(() {
        for(int i = 0; i < cards.length; i++){
          _cards.add(
              _Card(
                cards[i]["cvv"].toString(),
                cards[i]["number"].toString(),
                cards[i]["valid"].toString(),
              )
          );
        }
      });
      }
    );
  }

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
                cardNumber: _cards[0].number,
                cardExpiry: _cards[0].expiry,
                cvv: _cards[0].cvv,
                cardHolderName: "David Vodopija",
                bank: "Erste Banka",
                expdate: "Exp. Date",
                textname: "Name",
                textExpiry: "MM/YY",
                showBack: false,
              ),
              CustomCreditCard(
                cardNumber: _cards[1].number,
                cardExpiry: _cards[1].expiry,
                cvv: _cards[1].cvv,
                cardHolderName: "David Vodopija",
                bank: "Erste Banka",
                expdate: "Exp. Date",
                textname: "Name",
                textExpiry: "MM/YY",
                showBack: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Card{
  String cvv;
  String number;
  String expiry;
  _Card(this.cvv, this.number, this.expiry);
}