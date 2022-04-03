import 'package:flutter/material.dart';
import 'package:flutter_code/http_requests.dart';
import 'package:flutter_code/screens/chart_prediction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../custom_colors.dart';
import 'profile.dart';
import 'dart:math';

import 'chart_prediction_screen.dart';

class HistoryChart extends StatefulWidget{

  @override
  _HistoryChart createState() => _HistoryChart();
}

class _HistoryChart extends State<HistoryChart>{
  int _currentIndex = 1;

  var rng = Random();

  List<_SalesData> data = [
    _SalesData(1, 35),
    _SalesData(2, 5),
    _SalesData(3, 15),
    _SalesData(4, 32),
    _SalesData(5, 31),
    _SalesData(6, 6),
    _SalesData(7, 9),
    _SalesData(8, 11),
    _SalesData(9, 5),
  ];

  List<_SalesData> data2 = [
    _SalesData(1, 35),
    _SalesData(2, 5),
    _SalesData(3, 15),
    _SalesData(4, 32),
    _SalesData(5, 31),
    _SalesData(6, 6),
    _SalesData(7, 9),
    _SalesData(8, 11),
    _SalesData(9, 5),
  ];

  List<_PieData> data3 = [
    _PieData("Putovanja", 1, "35"),
    _PieData("Pokloni", 2, "8"),
    _PieData("Hrana", 3, "15"),
    _PieData("Gorivo", 4, "19"),
    _PieData("Sport", 5, "7"),
    _PieData("Ostalo", 6, "10"),
    _PieData("Higijena", 7, "32"),
  ];

  HTTPRequest hr = HTTPRequest();

  void initState(){
    super.initState();
    hr.predict().then((value) {
      setState(() {
      data.clear();
      for(int i = 0; i < value[1].length; i++){
        data.add(
          _SalesData(i, value[1][i]+(rng.nextInt(200)-100)),
        );
      }
      print(data);
      });
    });

    hr.getGraph().then((value){
      setState(() {
        data2.clear();
        for(int i = 0; i < 30; i++){
          data2.add(
            _SalesData(i, value[1][i]+(rng.nextInt(200)-100)),
          );
        }

        print(data2);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor().mainColor,
        title: Text("Povijest troškova", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w800),),
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
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //Initialize the chart widget
                Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: SfCartesianChart(
                        margin: EdgeInsets.fromLTRB(8, 8, 8, 24),
                        primaryXAxis: CategoryAxis(
                          isVisible: false,
                        ),
                        primaryYAxis: CategoryAxis(
                          minimum: 20,
                          visibleMinimum: 0
                        ),
                        // Chart title
                        title: ChartTitle(text: 'Prikaz prijašnjih troškova', textStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w500)),
                        // Enable legend
                        legend: Legend(isVisible: false),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: false),
                        series: <ChartSeries<_SalesData, int>>[
                          SplineSeries<_SalesData, int>(
                              dataSource: data2,
                              xValueMapper: (_SalesData sales, _) => sales.time,
                              yValueMapper: (_SalesData sales, _) => sales.sales,
                              name: "",
                              // Enable data label
                              dataLabelSettings: DataLabelSettings(isVisible: false))
                        ]
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: SfCartesianChart(
                        margin: const EdgeInsets.fromLTRB(8, 8, 8, 24),
                        primaryXAxis: CategoryAxis(
                          isVisible: false,
                        ),
                        // Chart title
                        title: ChartTitle(text: 'Predikcija budućih troškova', textStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w500)),
                        // Enable legend
                        legend: Legend(isVisible: false),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: false),
                        series: <ChartSeries<_SalesData, int>>[
                          SplineSeries<_SalesData, int>(
                              dataSource: data.sublist(0, 7),
                              xValueMapper: (_SalesData sales, _) => sales.time,
                              yValueMapper: (_SalesData sales, _) => sales.sales,
                              name: "",
                              // Enable data label
                              dataLabelSettings: const DataLabelSettings(isVisible: false)),
                          SplineSeries<_SalesData, int>(
                              dataSource: data.sublist(6),
                              xValueMapper: (_SalesData sales, _) => sales.time,
                              yValueMapper: (_SalesData sales, _) => sales.sales,
                              name: "",
                              color: Colors.red,
                              // Enable data label
                              dataLabelSettings: const DataLabelSettings(isVisible: false))
                        ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: SfCircularChart(
                        title: ChartTitle(text: 'Potrošnja po kategorijama'),
                        legend: Legend(isVisible: true),
                        series: <PieSeries<_PieData, String>>[
                          PieSeries<_PieData, String>(
                              explode: true,
                              explodeIndex: 0,
                              dataSource: data3,
                              xValueMapper: (_PieData data, _) => data.xData,
                              yValueMapper: (_PieData data, _) => data.yData,
                              dataLabelMapper: (_PieData data, _) => data.text,
                              dataLabelSettings: DataLabelSettings(isVisible: true)),
                        ]
                    )
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() {
          _currentIndex = i;

          if (_currentIndex == 0){
            Navigator.pop(context);
          }
          else if (_currentIndex == 3){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
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
            icon: Icon(Icons.insights_outlined,),
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

class _SalesData {
  _SalesData(this.time, this.sales);

  final int time;
  final int sales;
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}