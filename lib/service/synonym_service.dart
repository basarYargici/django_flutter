import 'dart:convert';

import 'package:local_host_workspace/model/synonym_model.dart';
import 'package:http/http.dart' as http;

class Service {
  Stream getData() async* {
    var url = "http://10.0.2.2:8000/synonym/?format=json";
    http.Response response = await http.get(url);
    print('Response body: ${response.body}, ${response.body.runtimeType}');
    yield synonymFromJson(response.body);
  }

  Stream addSynonym(Synonym synonym) async* {
    final response = await http.post(
      "http://10.0.2.2:8000/synonym/",
      headers: {"Content-Type": "application/json"},
      body: json.encode(synonym),
    );
    yield response;
  }
}
