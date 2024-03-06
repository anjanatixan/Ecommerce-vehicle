
import 'dart:isolate';
import 'package:http/http.dart' as http;

import 'baseService.dart';
import 'urls.dart';

class ApiService extends BaseService {
  @override
  Future deleteResponse(String url, var headers) async {
    dynamic responseJson;
    try {
      responseJson =
          await http.delete(Uri.parse(Urls.BASE_URL + url), headers: headers);
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }

  // @override
  // Future getResponse(String url, headers) async {
  //   dynamic responseJson;
  //   try {
  //     responseJson =
  //         await http.get(Uri.parse(Urls.BASE_URL + url), headers: headers);
  //     //log("get response" + Urls.BASE_URL + url);
  //   } catch (e) {
  //     throw e;
  //   }
  //   return responseJson;
  // }

  Future getResponse(String url, headers) async {
    dynamic responseJson;
    try {
      // responseJson =
      //     await http.get(Uri.parse(Urls.BASE_URL + url), headers: headers);
      final response = ReceivePort();
      await Isolate.spawn(
          isolate, [Urls.BASE_URL + url, headers, response.sendPort]);
      return await response.first;
      // log("get response" + Urls.BASE_URL + url);
    } catch (e) {
      throw e;
    }
  }

  void isolate(List<dynamic> args) async {
    final url = args[0];
    final headers = args[1];
    final sendPort = args[2];
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      responseJson = response;
      
    } catch (e) {
      throw e;
    }
    sendPort.send(responseJson);
  }

  @override
  Future patchResponse(String url, body, headers) async {
    var responseJson;
    try {
      final response = await http.patch(Uri.parse(Urls.BASE_URL + url),
          body: body, headers: headers);
      if (response.statusCode == 200) {
        responseJson = response;
      } else {
        responseJson = "{'message': 'error'}";
      }
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }

  @override
  Future postResponse(String url, body, headers) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(Urls.BASE_URL + url),
          body: body, headers: headers);

      responseJson = response;
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }

  @override
  Future putResponse(String url, body, headers) async {
    var responseJson;
    try {
      final response = await http.put(Uri.parse(Urls.BASE_URL + url),
          body: body, headers: headers);

      responseJson = response;
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }  
}
