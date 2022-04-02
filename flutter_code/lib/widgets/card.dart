import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget{

  String title;
  String description;
  String date;
  String price;

  CustomCard(this.title, this.description, this.date, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          ),
          child:
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(this.title, style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w800),),
                SizedBox(height: 8),
                Text(this.description, style: GoogleFonts.quicksand(fontSize: 13, fontWeight: FontWeight.w500),),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(this.date, style: GoogleFonts.quicksand(fontSize: 13, fontWeight: FontWeight.w500),),
                    Text(this.price + " kn", style: GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.w800),),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}