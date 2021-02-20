import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_host_workspace/model/model_enum.dart';
import 'package:local_host_workspace/model/synonym_model.dart';
import 'package:local_host_workspace/service/service.dart';
import 'package:provider/provider.dart';

class AddSynonymScreen extends StatelessWidget {
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _synonymController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Service serviceData = Provider.of<Service>(context, listen: false);
    String _modelName = Model.synonym.convert(Model.synonym);
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: buildColumn(_formKey, serviceData, _modelName, context),
        ),
      ),
    );
  }

  Column buildColumn(GlobalKey<FormState> _formKey, Service _provider, String _modelName, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "WORD",
            ),
            maxLength: 60,
            controller: _wordController,
            validator: (value) => _validate(value, 'Please enter word')),
        SizedBox(
          height: 20,
        ),
        TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "SYNONYM",
            ),
            maxLength: 60,
            controller: _synonymController,
            validator: (value) => _validate(value, 'Please enter synonym')),
        SizedBox(
          height: 20,
        ),
        TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "DESCRIPTION",
            ),
            controller: _descriptionController,
            validator: (value) => _validate(value, 'Please enter description')),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _provider.addData(
                    model: Synonym(word: _wordController.text, synonym: _synonymController.text, description: _descriptionController.text));
                Navigator.pop(context);
              }
            },
            child: Text("Add word")),
      ],
    );
  }

  String _validate(String value, String text) {
    return value.isEmpty ? text : null;
  }
}
