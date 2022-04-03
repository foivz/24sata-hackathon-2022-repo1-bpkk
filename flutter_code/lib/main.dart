import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code/http_requests.dart';
import 'package:flutter_code/screens/add_screen.dart';
import 'package:http/http.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'custom_colors.dart';

import 'widgets/card.dart';

import 'screens/add_screen.dart';
import 'screens/chart_history_screen.dart';
import 'screens/chart_prediction_screen.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'screens/login_screen.dart';
import 'screens/profile.dart';
import 'screens/wishlist_screen.dart';

void main() async {
  await Hive.initFlutter();
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

  List<Widget> cards = [ ];
  HTTPRequest hr = HTTPRequest();

  void getCards(){
    cards.clear();

    hr.getReceipts().then((value) {
      setState(() {
        var receipts = value[1];
        for(int i = 0; i < receipts.length; i++){
          var receipt = receipts[i];
          print(receipt);
          var date = DateTime.parse(receipt["date"]);
          final DateFormat formatter = DateFormat('dd.MM.yyyy.');
          cards.add(
            CustomCard(
                receipt["category"],
                receipt["description"],
                formatter.format(date),
                receipt["price"].toString()
            ),
          );
        }
        cards = List.from(cards.reversed);
      });
    });
  }

  void initState(){
    super.initState();
    hr.loginRequest("test", "OvoJeTest123!").then(
        (_){
          getCards();
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    int _currentIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: CustomColor().mainColor,
      ),
      body: Center(
        child: Stack(
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
            SingleChildScrollView(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: cards,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor().mainColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DodajTrosak())).then((value) => setState(() {
            _currentIndex = 0;
            getCards();
          }));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() {
          _currentIndex = i;

          if (_currentIndex == 1){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryChart())).then((value) => setState(() {
              _currentIndex = 0;
              getCards();
            }));
          }
          else if (_currentIndex == 2){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Wishlist())).then((value) => setState(() {
              _currentIndex = 0;
              getCards();
            }));
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
            icon: Icon(Icons.checklist_outlined),
            title: Text("Lista"),
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
