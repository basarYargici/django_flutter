import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:local_host_workspace/model/%C4%B1_model.dart';
import 'package:http/http.dart' as http;

class Service with ChangeNotifier {
  Future<List<dynamic>> getData({IModel model}) async {
    var modelName = model.runtimeType.toString().toLowerCase();
    print('MODEL : $model');
    print('MODELNAME: $modelName');
    var url = 'http://10.0.2.2:8000/$modelName/?format=json';
    var response = await http.get(url);
    print('Response $modelName body: ${response.body}, ${response.body.runtimeType}');
    notifyListeners();
    return model.fromJson(response.body);
  }

  Future deleteData({IModel model, int id}) async {
    var modelName = model.runtimeType.toString().toLowerCase();
    var url = 'http://10.0.2.2:8000/$modelName/$id/?format=json';
    await http.delete(url).then((value) => notifyListeners());
  }

  Future addData({IModel model}) async {
    var modelName = model.runtimeType.toString().toLowerCase();
    final response = await http.post(
      'http://10.0.2.2:8000/$modelName/',
      headers: {'Content-Type': 'application/json'},
      body: json.encode(model),
    );
    notifyListeners();
    print(response.reasonPhrase);
  }
}
