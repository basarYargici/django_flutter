import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_host_workspace/model/synonym_model.dart';
import 'package:local_host_workspace/service/synonym_service.dart';

class AddSynonymScreen extends StatelessWidget {
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
                     Service()
                        .addSynonym(Synonym(word: _wordController.text, synonym: _synonymController.text, description: _descriptionController.text));
                     Navigator.pop(context);
                  },
                  child: Text("add")),
            ],
          ),
        ),
      ),
    );
  }
}
