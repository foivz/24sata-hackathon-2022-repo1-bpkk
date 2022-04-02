import 'package:flutter/material.dart';
import 'package:flutter_code/screens/add_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'custom_colors.dart';

import 'widgets/card.dart';

import 'screens/add_screen.dart';
import 'screens/chart_history_screen.dart';
import 'screens/chart_prediction_screen.dart';
import 'screens/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BPKK',
      theme: ThemeData(),
      home: const MyHomePage(title: 'BPKK'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    int _currentIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CustomCard("Naslov", "Opis troska", "Datum", "2000"),
              CustomCard("Naslov", "Opis troska", "Datum", "2000"),
              CustomCard("Naslov", "Opis troska", "Datum", "2000"),
              CustomCard("Naslov", "Opis troska", "Datum", "2000"),
              CustomCard("Naslov", "Opis troska", "Datum", "2000"),
              CustomCard("Naslov", "Opis troska", "Datum", "2000"),
              CustomCard("Naslov", "Opis troska", "Datum", "2000"),
              CustomCard("Naslov", "Opis troska", "Datum", "2000"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DodajTrosak())).then((value) => setState(() {_currentIndex = 0;}));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() {
          _currentIndex = i;

          if (_currentIndex == 1){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryChart())).then((value) => setState(() {_currentIndex = 0;}));
          }
          else if (_currentIndex == 2){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PredictionChart())).then((value) => setState(() {_currentIndex = 0;}));
          }

          else if (_currentIndex == 3){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile())).then((value) => setState(() {_currentIndex = 0;}));
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
            title: Text("Predikcija"),
            selectedColor: CustomColor().mainColor,
          ),
        ],
      ),
    );
  }
}
