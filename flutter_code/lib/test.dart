import 'http_requests.dart';

void main() async {
  var hr = HTTPRequest();
  
  await hr.loginRequest("test", "OvoJeTest123!");

  print((await hr.getReceipts())[1]);
}