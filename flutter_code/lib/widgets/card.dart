import 'package:flutter/material.dart';

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
          elevation: 5,
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
                Text(this.title),
                SizedBox(height: 4,),
                Text(this.description),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(this.date),
                    Text(this.price + " kn"),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}