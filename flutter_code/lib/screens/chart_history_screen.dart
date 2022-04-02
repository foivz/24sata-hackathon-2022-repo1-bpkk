import 'package:flutter/material.dart';
import 'package:flutter_code/screens/chart_prediction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../custom_colors.dart';

import 'chart_prediction_screen.dart';

class HistoryChart extends StatefulWidget{

  @override
  _HistoryChart createState() => _HistoryChart();
}

class _HistoryChart extends State<HistoryChart>{
  int _currentIndex = 1;

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 5),
    _SalesData('Mar', 15),
    _SalesData('Apr', 32),
    _SalesData('May', 31),
    _SalesData('Jun', 6),
    _SalesData('Jul', 9),
    _SalesData('Aug', 11),
    _SalesData('Sep', 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor().mainColor,
        title: Text("Povijest troškova", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w800),),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          //Initialize the chart widget
          SfCartesianChart(
            margin: EdgeInsets.fromLTRB(8, 32, 32, 0),
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Prikaz prijašnjih troškova', textStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w500)),
            // Enable legend
            legend: Legend(isVisible: false),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: false),
            series: <ChartSeries<_SalesData, String>>[
              SplineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: "",
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]
          ),
      ]),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() {
          _currentIndex = i;

          if (_currentIndex == 0){
            Navigator.pop(context);
          }
          else if (_currentIndex == 2){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => PredictionChart()));
          }
        }),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Troškovi"),
            selectedColor: CustomColor().mainColor,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.show_chart_outlined),
            title: Text("Potrošnja"),
            selectedColor: CustomColor().mainColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.show_chart_outlined),
            title: Text("Predikcija"),
            selectedColor: CustomColor().mainColor,
          ),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}