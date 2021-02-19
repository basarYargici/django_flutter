import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_host_workspace/model/model_enum.dart';
import 'package:local_host_workspace/model/synonym_model.dart';
import 'package:local_host_workspace/screens/add_synonym_screen.dart';
import 'package:local_host_workspace/screens/detail_screen.dart';
import 'package:local_host_workspace/service/service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  List<Synonym> futureData;

  @override
  Widget build(BuildContext context) {
    String _modelName = Model.synonym.convert(Model.synonym);

    return Scaffold(
      appBar: buildAppBar(),
      body: Consumer<Service>(
        builder: (context, serviceData, child) => buildFutureBuilder(serviceData, _modelName),
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "Django backend and flutter frontend",
      ),
      centerTitle: true,
    );
  }

  FutureBuilder<List> buildFutureBuilder(Service serviceData, String _modelName) {
    return FutureBuilder(
      future: serviceData.getData(modelName: _modelName),
      builder: (context, snapshot) {
        futureData = snapshot.data;
        if (snapshot.hasData) {
          if (futureData.isEmpty) {
            return Center(child: Text("EEEEEEEMMMPTY"));
          }
          return buildListView(_modelName, serviceData);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  ListView buildListView(String _modelName, Service serviceData) {
    return ListView.builder(
      primary: true,
      itemCount: futureData.length,
      itemBuilder: (BuildContext context, int index) {
        return buildDismissible(_modelName, serviceData, index, context);
      },
    );
  }

  Dismissible buildDismissible(String _modelName, Service serviceData, int index, BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        print(_modelName);
        serviceData.deleteData(modelName: _modelName, id: futureData[index].id);
        futureData.removeAt(index);
      },
      child: buildListTile(index, context),
    );
  }

  Padding buildListTile(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
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
                  builder: (context) => DetailScreen(
                        text: futureData[index].synonym,
                      )));
        },
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddSynonymScreen()));
      },
    );
  }
}
