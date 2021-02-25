import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_host_workspace/model/model_enum.dart';
import 'package:local_host_workspace/model/translate_model.dart';
import 'package:local_host_workspace/service/service.dart';
import 'package:provider/provider.dart';

class AddTranslateScreen extends StatelessWidget {
  final TextEditingController _englishController = TextEditingController();
  final TextEditingController _turkishController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var serviceData = Provider.of<Service>(context, listen: false);
    var _modelName = Model.synonym.convert(Model.synonym);
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
              labelText: 'ENGLISH',
            ),
            maxLength: 60,
            controller: _englishController,
            validator: (value) => _validate(value, 'Please enter an English word')),
        SizedBox(
          height: 20,
        ),
        TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'TURKISH',
            ),
            maxLength: 60,
            controller: _turkishController,
            validator: (value) => _validate(value, 'Please enter a Turkish synonym')),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await _provider.addData(model: Translate(english: _englishController.text, turkish: _turkishController.text.toString()));
                Navigator.pop(context);
              }
            },
            child: Text('Add word')),
      ],
    );
  }

  String _validate(String value, String text) {
    return value.isEmpty ? text : null;
  }
}
