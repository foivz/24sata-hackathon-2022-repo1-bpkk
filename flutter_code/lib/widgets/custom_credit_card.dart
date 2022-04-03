import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';

class CustomCreditCard extends StatefulWidget{

  String cardNumber;
  String cardExpiry;
  String cvv;
  String cardHolderName;
  String bank;
  String expdate;
  String textname;
  String textExpiry;
  bool showBack;

  CustomCreditCard({
    required this.cardNumber,
    required this.cardExpiry,
    required this.cvv,
    required this.cardHolderName,
    required this.bank,
    required this.expdate,
    required this.textname,
    required this.textExpiry,
    required this.showBack,
  });

  @override
  _CustomCreditCard createState() => _CustomCreditCard();
}

class _CustomCreditCard extends State<CustomCreditCard>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.showBack = !widget.showBack;
        });
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
        child: CreditCard(
            cardNumber: widget.cardNumber,
            cardExpiry: widget.cardExpiry,
            cardHolderName: widget.cardHolderName,
            cvv: widget.cvv,
            bankName: widget.bank,
            cardType: CardType.visa, // Optional if you want to override Card Type
            showBackSide: widget.showBack,
            frontBackground: CardBackgrounds.black,
            backBackground: CardBackgrounds.white,
            showShadow: true,
            textExpDate: widget.expdate,
            textName: widget.textname,
            textExpiry: widget.textExpiry
        ),
      ),
    );
  }
}