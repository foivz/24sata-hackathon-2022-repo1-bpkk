
//Ovaj file je samo backup

import 'package:flutter/material.dart';

import '../widgets/card.dart';

class TroskoviPage extends StatefulWidget{
  @override
  _TroskoviPage createState() => _TroskoviPage();
}

class _TroskoviPage extends State<TroskoviPage>{

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("BPKK"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CustomCard("Naslov", "Opis troska", "Datum", "2000"),
            CustomCard("Naslov", "Opis troska", "Datum", "2000"),
            CustomCard("Naslov", "Opis troska", "Datum", "2000"),
            CustomCard("Naslov", "Opis troska", "Datum", "2000"),
            CustomCard("Naslov", "Opis troska", "Datum", "2000"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("test");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}