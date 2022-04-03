/// Skripta je namijenjena razgovoru sa serverom. U ovom dijelu koda,
/// dart se spaja na fastAPI, te time omogućava konekciju i komunikaciju
/// između frontenda i backenda.
import 'dart:collection';
import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as Http;
import 'package:http_parser/http_parser.dart' as hp;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

bool debug = false;
String token = "";

class HTTPRequest {
  Box? tokenBox;
  Box? usernameBox;

  final String domain = 'http://192.168.254.20:4000';
  Map<String, String> headers = HashMap();

  HTTPRequest() {
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
  }

  Future<void> checkBoxes() async {
    if (debug) return;
    tokenBox ??= await Hive.openBox("userToken");
    usernameBox ??= await Hive.openBox("username");
  }

  Future<void> deleteBoxes() async {
    if (debug) return;
    await checkBoxes().then((value) {
      tokenBox?.deleteAll(tokenBox!.keys);
      usernameBox?.deleteAll(usernameBox!.keys);
    });
  }

  Future<Http.Response> _sendPostRequest(
      {required endpoint,
      required dict,
      bool sendToken = false,
      int timeout = 4}) async {
    Map<String, String> newHeaders = HashMap();
    newHeaders['Accept'] = 'application/json';
    newHeaders['Content-type'] = 'application/json';
    if (sendToken) {
      if (!debug) {
        if (tokenBox!.keys.contains("token")) {
          newHeaders['X-Token'] = tokenBox!.get("token");
        } else {
          /*Navigator.of(context!).popUntil((route) => route.isFirst);
        Navigator.pop(context!);
        Navigator.push(context!, MaterialPageRoute(
            builder: (context) => LoginPage()));  */
          print("yooo you dont have access");
        }
      } else {
        newHeaders['X-Token'] = token;
      }
    }

    var request = await Http.post(Uri.parse(domain + endpoint),
        headers: newHeaders,
        body: jsonEncode(dict),
        encoding: Encoding.getByName('utf-8'));
    if (request.body == "Internal Server Error")
      return Http.Response(jsonEncode("Internal Server Error"), 500);
    return request;
  }

  Future<List> loginRequest(String username, String passwd) async {
    await checkBoxes();
    String endpoint = "/login/";

    Http.Response response = await _sendPostRequest(
        endpoint: endpoint,
        dict: {"username": username, "passw": passwd},
        timeout: 4);

    await deleteBoxes();

    if (response.statusCode == 200) {
      await checkBoxes().then((value) {
        if (debug) {
          token = jsonDecode(response.body)['token'];
        } else {
          tokenBox!.put("token", jsonDecode(response.body)['token']);
          usernameBox!.put("username", username);
        }
      });
    }
    return [
      response.statusCode,
      jsonDecode(utf8.decode(response.body.codeUnits))
    ];
  }

  Future<List> registerRequest(String username, String email, String passwd,
      {int? fid}) async {
    await checkBoxes();

    String endpoint = "/register/";
    Http.Response response = await _sendPostRequest(
      endpoint: endpoint,
      dict: {
        "username": username,
        "passw": passwd,
        "email": email,
        "familyid": fid ?? 0,
      },
      timeout: 5,
    );

    await deleteBoxes();

    if (response.statusCode == 200) {
      await checkBoxes().then((value) {
        if (debug) {
          token = jsonDecode(response.body)['token'];
        } else {
          tokenBox!.put("token", jsonDecode(response.body)['token']);
          usernameBox!.put("username", username);
        }
      });
    }
    return [
      response.statusCode,
      jsonDecode(utf8.decode(response.body.codeUnits))
    ];
  }

  Future<List> logoutRequest() async {
    await checkBoxes();

    String endpoint = "/logout/";
    Http.Response response =
        await _sendPostRequest(endpoint: endpoint, dict: {}, sendToken: true);

    await deleteBoxes();

    return [
      response.statusCode,
      jsonDecode(utf8.decode(response.body.codeUnits))
    ];
  }

  Future<List> newReceipt(
      String category, String description, int price, List items,
      {DateTime? time}) async {
    await checkBoxes();

    final DateFormat formatter = DateFormat('yyyy-MM-ddTkk:mm:ss');
    // print(formatter.format(time!));

    String endpoint = "/add/";
    Http.Response response = await _sendPostRequest(
        endpoint: endpoint,
        dict: {
          "category": category,
          "description": description,
          "price": price,
          "items": items,
          "time": time == null ? null : formatter.format(time),
        },
        sendToken: true);
    return [
      response.statusCode,
      jsonDecode(utf8.decode(response.body.codeUnits))
    ];
  }

  Future<List> uploadImage(XFile? img, String category, String description, DateTime time) async {
    await checkBoxes();
    if (img == null) {
      throw Exception("No good");
    }

    final DateFormat formatter = DateFormat('yyyy-MM-ddTkk:mm:ss');

    String endpoint = "/getData/";
    Map<String, String> newHeaders = HashMap();
    if (!debug) {
      if (tokenBox!.keys.contains("token")) {
        print(tokenBox!.get("token"));
        token = tokenBox!.get("token");
        print(token);
      }
      else {
        print("no token o_o");
      }
    }
    print(token);
    var request = Http.MultipartRequest("POST", Uri.parse(domain + endpoint))
      ..headers['X-Token'] = token
      ..headers['category'] = category
      ..headers['description'] = description
      ..headers['time'] = formatter.format(time)
      ..files.add(await Http.MultipartFile.fromPath("file", img.path, contentType: hp.MediaType("image", "png")));

    var response = await request.send();

    return [
      response.statusCode,
    ];
  }

  Future<List> getReceipts({int? fid}) async {
    await checkBoxes();

    String endpoint = "/getReceipts/";
    Http.Response response = await _sendPostRequest(
        endpoint: endpoint,
        dict: {
          "fid": fid,
        },
        sendToken: true);
    return [
      response.statusCode,
      jsonDecode(utf8.decode(response.body.codeUnits))
    ];
  }

  Future<List> setFid(int fid) async {
    await checkBoxes();

    String endpoint = "/posts/getPost/";
    Http.Response response = await _sendPostRequest(
        endpoint: endpoint, dict: {"fid": fid}, sendToken: true);
    return [
      response.statusCode,
      jsonDecode(utf8.decode(response.body.codeUnits))
    ];
  }

  Future<List> checkTokenRequest() async {
    await checkBoxes();

    String endpoint = "/checkToken/";
    Http.Response response =
        await _sendPostRequest(endpoint: endpoint, dict: {}, sendToken: true);
    return [
      response.statusCode,
      jsonDecode(utf8.decode(response.body.codeUnits))
    ];
  }

  Future<List> predict() async {
    await checkBoxes();

    String endpoint = "/predict/";
    Http.Response response =
    await _sendPostRequest(endpoint: endpoint, dict: {}, sendToken: true);
    return [
      response.statusCode,
      jsonDecode(utf8.decode(response.body.codeUnits))
    ];
  }

  Future<List> getGraph() async {
    await checkBoxes();

    String endpoint = "/getGraph/";
    Http.Response response =
    await _sendPostRequest(endpoint: endpoint, dict: {}, sendToken: true);
    return [
      response.statusCode,
      jsonDecode(utf8.decode(response.body.codeUnits))
    ];
  }

  Future<List> getCards() async {
    await checkBoxes();

    String endpoint = "/getCard/";
    Http.Response response =
    await _sendPostRequest(endpoint: endpoint, dict: {}, sendToken: true);

    return [
      response.statusCode,
      jsonDecode(utf8.decode(response.body.codeUnits))
    ];
  }
}
