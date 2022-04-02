import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'http_requests.dart';


List <dynamic> racuni = [];
List <dynamic> tmp = [];
Map costOnDay = new Map();
Map cntDay = new Map();
/*
double predictCostByMath(int start_date, double interval){ // predicta cost za sve nakon start_date
  double ev = 0;
  var prob_cnt = new Map();
  int maxValue = 0;
  double numEvents = 0;

  for (int i = 0; i < racuni.length; i++) {
    if (racuni[i].date >= start_date) {
      prob_cnt[(racuni[i].cost / interval).toInt()] = prob_cnt[(racuni[i].cost / interval).toInt()]??0 + 1;
      numEvents++;
      maxValue = max(maxValue, (racuni[i].cost / interval).toInt());
    }
  }

  for (int i = 0; i <= maxValue; i++){
    ev += ((prob_cnt[i]??0) / numEvents) * (i + 0.5) * interval;
  }

  return ev;
}*/

w(start, end, loc) {
  wf(x){
    return sqrt(x);
  }
  final a = loc.difference(start);
  final b = end.difference(start);
  return ((wf((a.inDays + 1) / (b.inDays + 1))) + 1) / 2;
}

double predictNextDay(uid){
  var start = DateTime.now();
  var end = DateTime(2000);
  for (int i = 0; i < tmp.length; i++){
    if (tmp[i]["uid"] == uid){
      final date = DateTime.parse(tmp[i]["date"]);
      if (date.compareTo(start) < 0){
        start = date;
      }
      if (date.compareTo(end) > 0){
        end = date;
      }
    }
  }

  Map sviW = new Map();

  //print(start);
  //print(end);

  double sum = 0, wsum = 0;

  for (int i = 0; i < tmp.length; i++){
    if (tmp[i]["uid"] == uid){
      var date = DateTime.parse(tmp[i]["date"]);
      sum += w(start, end, date) * tmp[i]["price"];
      sviW[w(start, end, date)] = 1;
    }
  }
  sviW.keys.forEach((el) => wsum += el);
  return sum / wsum;
}

Future<void> dobiRacune() async{
  var hr = HTTPRequest();

  await hr.loginRequest("test", "OvoJeTest123!");

  racuni = (await hr.getReceipts())[1];
}

calcNextXDays(x, uid){
  tmp = racuni;
  final today = DateTime.now();
  for (int i = 1; i <= x; i++){
    var cost = predictNextDay(uid);
    Map day = new Map();
    day["date"] = today.add(Duration(days: i)).toIso8601String();
    day["price"] = cost;
    tmp.add(day);
    //print(tmp);
    print(cost);
  }
}


void main() async {
  await dobiRacune();
  final date = DateTime.parse(racuni[0]["date"]);
  tmp = racuni;
  print(predictNextDay(2));
  calcNextXDays(7, 2);
}