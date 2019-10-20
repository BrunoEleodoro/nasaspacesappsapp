import 'dart:io';

import 'package:app/pages/default_pages/failure/failure.dart';
import 'package:app/pages/default_pages/loading/loading_page.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:app/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  static Future<Dio> getDio() {
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    return Future.value(dio);
  }

  static postRequestFile(context, url, data) async {
    Dio dio = await getDio();

    var headers = {
      // 'Content-type': 'application/json',
      'accept': '*/*'
    };
    // if (globals.token != "") {
    //   headers = {
    //     // 'Content-type': 'application/json',
    //     'Authorization': "Bearer " + globals.token
    //   };
    // }
    var options = Options(headers: headers);
    var res = await dio.post(url, data: data, options: options);
    var json = jsonDecode(res.toString());
    return json;
  }

  static postRequest(context, url, data) async {
    Dio dio = await getDio();
    var headers = {
      'Content-type': 'application/json',
    };
    if (globals.token != "") {
      headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer " + globals.token
      };
    }
    var options = Options(headers: headers);
    var res = await dio.post(url, data: jsonEncode(data), options: options);
    var json = jsonDecode(res.toString());
    return json;
  }

  static postFile(context, url, data) async {
    Dio dio = await getDio();
    var headers = {'Authorization': "Bearer " + globals.token};
    var options = Options(headers: headers);
    var res = await dio.post(url, data: data, options: options);
    var json = jsonDecode(res.toString());
    return json;
  }

  static putRequest(context, url, data) async {
    Dio dio = await getDio();
    var headers = {
      'Content-type': 'application/json',
    };
    if (globals.token != "") {
      headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer " + globals.token
      };
    }
    var options = Options(headers: headers);
    var res = await dio.put(url, data: jsonEncode(data), options: options);
    var json = jsonDecode(res.toString());
    return json;
  }

  static deleteRequest(context, url, data) async {
    Dio dio = await getDio();
    var headers = {
      'Content-type': 'application/json',
    };
    if (globals.token != "") {
      headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer " + globals.token
      };
    }
    var options = Options(headers: headers);
    var res = await dio.delete(url, data: jsonEncode(data), options: options);
    var json = jsonDecode(res.toString());
    return json;
  }

  static getRequest(url) async {
    Dio dio = await getDio();
    var headers = {
      'Content-type': 'application/json',
    };
    if (globals.token != "") {
      headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer " + globals.token
      };
    }

    var options = Options(headers: headers);
    var res = await dio.get(url, options: options);
    var json = jsonDecode(res.toString());
    return json;
  }

  static void logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    globals.token = "";
    Provider.of<FailureNotifier>(context, listen: true)
        .displayFailure("Sessão expirada");

    Navigator.pushReplacementNamed(context, '/');
  }

  static Future<bool> tokenExpired(context) {
    if (globals.token == "") {
      return Future.value(false);
    }

    var partes = globals.token.split(".");
    var expiration = jsonDecode(utf8
        .decode(base64Url.decode(partes[1].trim().toString() + "=")))['exp'];
    // print(partes[1].toString());
    // // print(globals.token);
    // try {
    //   print(utf8.decode(base64Url.decode(partes[1].trim().toString() + "=")));
    // } catch (ex) {
    //   print(ex);
    // }

    if ((expiration * 1000) < DateTime.now().millisecondsSinceEpoch) {
      logout(context);
      return Future.value(true);
    }
    return Future.value(false);
  }
}
