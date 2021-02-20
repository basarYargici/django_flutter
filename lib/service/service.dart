import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:local_host_workspace/model/%C4%B1_model.dart';
import 'package:local_host_workspace/model/synonym_model.dart';
import 'package:http/http.dart' as http;

class Service with ChangeNotifier {
  Future<List<dynamic>> getData({IModel model}) async {
    String modelName = model.runtimeType.toString().toLowerCase();
    print("model $model");
    print("modelName $modelName");
    var url = "http://10.0.2.2:8000/$modelName/?format=json";
    http.Response response = await http.get(url);
    print('Response $modelName body: ${response.body}, ${response.body.runtimeType}');
    return synonymFromJson(response.body);
  }

  Future deleteData({IModel model, int id}) async {
    String modelName = model.runtimeType.toString().toLowerCase();
    var url = "http://10.0.2.2:8000/$modelName/$id/?format=json";
    await http.delete(url).then((value) => notifyListeners());
  }

  Future addData({IModel model}) async {
    String modelName = model.runtimeType.toString().toLowerCase();
    final response = await http.post(
      "http://10.0.2.2:8000/$modelName/",
      headers: {"Content-Type": "application/json"},
      body: json.encode(model),
    );
    notifyListeners();
    print(response.reasonPhrase);
  }
}
