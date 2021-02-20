import 'package:local_host_workspace/model/%C4%B1_model.dart';

class Translate with IModel{
  int id;
  String english;
  String turkish;

  Translate({this.id, this.english, this.turkish});

  Translate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    english = json['english'];
    turkish = json['turkish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['english'] = this.english;
    data['turkish'] = this.turkish;
    return data;
  }
}
