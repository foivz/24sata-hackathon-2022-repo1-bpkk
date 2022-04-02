import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../custom_colors.dart';

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
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          //Initialize the chart widget
          SfCartesianChart(
            margin: EdgeInsets.fromLTRB(8, 32, 32, 0),
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Povijest potrošnje', textStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w500)),
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

          if (_currentIndex == 1){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryChart())).then((value) => setState(() {_currentIndex = 0;}));

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