import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_host_workspace/model/%C4%B1_model.dart';
import 'package:local_host_workspace/model/model_enum.dart';
import 'package:local_host_workspace/model/synonym_model.dart';
import 'package:local_host_workspace/model/translate_model.dart';
import 'package:local_host_workspace/service/service.dart';
import 'package:provider/provider.dart';

class NewHome extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> with SingleTickerProviderStateMixin {
  TabController _tabController; // To control switching tabs
  ScrollController _scrollViewController; // To control scrolling

  List<Synonym> futureData;
  IModel _model;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {
      print("Entered");
      setState(() {
        switch (_tabController.index) {
          case 0:
            _model = Synonym();
            print("Model init $_model");
            break;
          case 1:
            _model = Translate();
            print("Model init $_model");
            break;
          default:
            throw Exception("got to _tabController listener");
        }
      });
    });
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Service>(
      builder: (context, serviceData, child) {
        return SafeArea(
          child: Scaffold(
            body: NestedScrollView(
              controller: _scrollViewController,
              headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: Text(
                      "Flutter && Django",
                    ),
                    centerTitle: true,
                    floating: true,
                    pinned: true,
                    snap: true,
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: <Widget>[
                        Tab(
                          child: Text(Model.values[0].convert(Model.values[0]).toUpperCase()),
                        ),
                        Tab(
                          child: Text(Model.values[1].convert(Model.values[1]).toUpperCase()),
                        ),
                      ],
                      indicatorColor: Colors.white,
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  FutureBuilder(
                    future: serviceData.getData(model: _model),
                    builder: (context, snapshot) {
                      futureData = snapshot.data;
                      if (snapshot.hasData) {
                        if (futureData.isEmpty) {
                          return Center(child: Text("EEEEEEEMMMPTY"));
                        }
                        return Text("Listtile");
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  Text("a"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// FutureBuilder<List> buildFutureBuilder(Service serviceData, String _modelName) {
//   return FutureBuilder(
//     future: serviceData.getData(modelName: _modelName),
//     builder: (context, snapshot) {
//       futureData = snapshot.data;
//       if (snapshot.hasData) {
//         if (futureData.isEmpty) {
//           return Center(child: Text("EEEEEEEMMMPTY"));
//         }
//         return buildListView(_modelName, serviceData);
//       }
//       return Center(child: CircularProgressIndicator());
//     },
//   );
// }
}
/*
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
        "Flutter && Django",
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
        //serviceData.deleteData(modelName: _modelName, id: futureData[index].id);
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
*/
