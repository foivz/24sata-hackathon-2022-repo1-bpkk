import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../custom_colors.dart';
import 'profile.dart';
import 'chart_history_screen.dart';


class PredictionChart extends StatefulWidget{

  @override
  _PredictionChart createState() => _PredictionChart();
}

class _PredictionChart extends State<PredictionChart>{
  int _currentIndex = 2;

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Initialize the chart widget
        SfCartesianChart(
          margin: EdgeInsets.fromLTRB(8, 32, 32, 0),
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: 'Predikcija budućih troškova', textStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w500)),
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
      ]
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}