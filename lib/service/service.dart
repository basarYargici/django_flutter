import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:local_host_workspace/model/synonym_model.dart';
import 'package:http/http.dart' as http;
import 'package:local_host_workspace/model/translate_model.dart';

class Service with ChangeNotifier {
  Future<List<dynamic>> getData({String modelName}) async {
    var url = "http://10.0.2.2:8000/$modelName/?format=json";
    http.Response response = await http.get(url);
    print('Response $modelName body: ${response.body}, ${response.body.runtimeType}');
    return synonymFromJson(response.body);
  }

  Future deleteData({String modelName, int id}) async {
    var url = "http://10.0.2.2:8000/$modelName/$id/?format=json";
    await http.delete(url).then((value) => notifyListeners());
  }

  Future addData({String modelName, Synonym synonym, Translate translate}) async {
    Object encodeName = synonym != null ? synonym : translate;
    final response = await http.post(
      "http://10.0.2.2:8000/$modelName/",
      headers: {"Content-Type": "application/json"},
      body: json.encode(encodeName),
    );
    notifyListeners();
    print(response.reasonPhrase);
  }
}
