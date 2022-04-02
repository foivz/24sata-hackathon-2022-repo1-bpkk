import 'http_requests.dart';
import 'dart:math';

void main() async {
  var hr = HTTPRequest();

  await hr.loginRequest("test", "OvoJeTest123!");

  // print((await hr.getReceipts())[1]);

  String oupis = "Neki kul opis :sunglasses:";
  List<String> tagArr = [
    "Putovanja",
    "Shopping",
    "Pokloni",
    "Hrana",
    "Gorivo",
    "Sport",
    "Ostalo",
    "Bijela Tehnika",
    "Higijena"
  ];
  var rng = Random();
  // var nicetime = DateTime.utc(2022, 4, 2);
  var nicetime = DateTime.now();
  int amm = 100;
  for (int i = 0; i < amm; i++) {
    int price = rng.nextInt(800);
    String tag = tagArr[rng.nextInt(8)];
    String itemovi = "";
    int it = rng.nextInt(6);
    for (int i = 0; i <= it; i++) {
      itemovi += rng.nextInt(100).toString();
      if (i != it) itemovi += " ";
    }
    int subd = rng.nextInt(250);
    price = ((1.8 - subd / 250) * price).ceil();
    var thetime = nicetime.subtract(Duration(days: subd));
    await hr.newReceipt(tag, oupis, price, itemovi, time: thetime);
  }
}
