import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:local_host_workspace/model/%C4%B1_model.dart';
import 'package:http/http.dart' as http;

class Service with ChangeNotifier {
  final localBaseUrl = 'http://10.0.2.2:8000';
  final pythonAnywhereBaseUrl = 'http://15minmail.pythonanywhere.com';

  Future<List<dynamic>> getData({IModel model}) async {
    var modelName = model.runtimeType.toString().toLowerCase();
    print('MODEL : $model');
    print('MODELNAME: $modelName');
    // var url = '$localBaseUrl/$modelName/?format=json';
    var url = '$pythonAnywhereBaseUrl/$modelName/?format=json';
    var response = await http.get(url);
    print('Response $modelName body: ${response.body}, ${response.body.runtimeType}');
    notifyListeners();
    return model.fromJson(response.body);
  }

  Future deleteData({IModel model, int id}) async {
    var modelName = model.runtimeType.toString().toLowerCase();
    // var url = '$localBaseUrl/$modelName/$id/?format=json';
    var url = '$pythonAnywhereBaseUrl/$modelName/$id/?format=json';
    await http.delete(url).then((value) => notifyListeners());
  }

  Future addData({IModel model}) async {
    var modelName = model.runtimeType.toString().toLowerCase();
    final response = await http.post(
      '$pythonAnywhereBaseUrl/$modelName/', // '$localBaseUrl/$modelName/',
      headers: {'Content-Type': 'application/json'},
      body: json.encode(model),
    );
    notifyListeners();
    print(response.reasonPhrase);
  }
}
