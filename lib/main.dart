import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Synonym> futureData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Django backend and flutter frontend",
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Service().getData(),
        builder: (context, snapshot) {
          futureData = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              primary: true,
              itemCount: futureData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.description),
                  title: Text(futureData[index].word),
                  subtitle: Text(
                    futureData[index].description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoPage(
                                  text: futureData[index].synonym,
                                )));
                  },
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddWord()));
        },
      ),
    );
  }
}

class Service {
  Future<List<Synonym>> getData() async {
    var url = "http://10.0.2.2:8000/synonym/?format=json";
    http.Response response = await http.get(url);
    print('Response body: ${response.body}, ${response.body.runtimeType}');
    return synonymFromJson(response.body);
  }

  Future addSynonym(Synonym synonym) async {
    final response = await http.post(
      "http://10.0.2.2:8000/synonym/",
      headers: {"Content-Type": "application/json"},
      body: json.encode(synonym),
    );
    print(response.reasonPhrase);
  }
}

class InfoPage extends StatelessWidget {
  final String text;

  const InfoPage({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Synonym"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }
}

class AddWord extends StatelessWidget {
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _synonymController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "WORD",
                ),
                controller: _wordController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "SYNONYM",
                ),
                controller: _synonymController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "DESCRIPTION",
                ),
                controller: _descriptionController,
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () async {
                    await Service()
                        .addSynonym(Synonym(word: _wordController.text, synonym: _synonymController.text, description: _descriptionController.text))
                        .then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            )));
                  },
                  child: Text("add")),
            ],
          ),
        ),
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final synonym = synonymFromJson(jsonString);

List<Synonym> synonymFromJson(String str) => List<Synonym>.from(json.decode(str).map((x) => Synonym.fromJson(x)));

String synonymToJson(List<Synonym> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Synonym {
  Synonym({
    this.word,
    this.synonym,
    this.description,
  });

  String word;
  String synonym;
  String description;

  factory Synonym.fromJson(Map<String, dynamic> json) => Synonym(
        word: json["word"],
        synonym: json["synonym"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "synonym": synonym,
        "description": description,
      };
}
