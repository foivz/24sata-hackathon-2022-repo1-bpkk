import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_colors.dart';

class Wishlist extends StatefulWidget{

  @override
  _Wishlist createState() => _Wishlist();
}

class _Wishlist extends State<Wishlist>{

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista za kupovinu", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w600),),
        backgroundColor: CustomColor().mainColor,
      ),
    );
  }
}