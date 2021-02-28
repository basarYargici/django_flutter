import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:local_host_workspace/model/%C4%B1_model.dart';
import 'package:local_host_workspace/model/model_enum.dart';
import 'package:local_host_workspace/model/synonym_model.dart';
import 'package:local_host_workspace/model/translate_model.dart';
import 'package:local_host_workspace/screens/components/boomFabWidget.dart';
import 'package:local_host_workspace/screens/detail_screen.dart';
import 'package:local_host_workspace/service/service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController _tabController; // To control switching tabs

  IModel _model; // Translate and Synonym extends IModel, that means we can use IModel as reference

  Future<List<dynamic>> _synonymData; // Will store synonym data list
  Future<List<dynamic>> _translateData; // Will store translate data list

  @override
  void initState() {
    super.initState();
    // We will have two tab
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );

    // Declare and initialize for first time both models
    _model = Synonym();
    _synonymData = Service().getData(model: Synonym());
    _translateData = Service().getData(model: Translate());

    // If tab index changes, model should be changed
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            try {
              _model = Synonym();
            } catch (e) {
              throw Exception('syn error');
            } //_synonymData = Service().getData(model: Synonym());
            break;
          case 1:
            try {
              _model = Translate();
            } catch (e) {
              throw Exception('translate error');
            }
            //_translateData = Service().getData(model: Translate());
            break;
          default:
            throw Exception('got to _tabController listener');
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var serviceData = Provider.of<Service>(context);
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return [
              buildSliverAppBar(),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              // buildSynonymView(serviceData),
              // buildTranslateView(serviceData),

              RefreshIndicator(
                onRefresh: () {
                  return _synonymData = getData(serviceData, _model);
                },
                child: buildSynonymView(serviceData),
              ),
              RefreshIndicator(
                onRefresh: () {
                  return _translateData = getData(serviceData, _model);
                },
                child: buildTranslateView(serviceData),
              ),
            ],
          ),
        ),
        floatingActionButton: buildBoomFAB(context),
      ),
    );
  }

  Future<List> getData(Service serviceData, IModel model) {
    Future<List<dynamic>> data;
    data = serviceData.getData(model: model);
    return data;
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      title: Text(
        'Flutter && Django',
      ),
      centerTitle: true,
      floating: true,
      pinned: false,
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
    );
  }

  FutureBuilder<List<dynamic>> buildSynonymView(Service serviceData) {
    List<Synonym> futureSynonymList;
    return FutureBuilder(
      future: _synonymData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          futureSynonymList = snapshot.data;
          if (snapshot.data != null) {
            if (futureSynonymList.isEmpty) {
              return ListView(children: [Center(child: Text('EEEEEEEMMMPTY'))]);
            } else {
              return ListView.builder(
                primary: true,
                itemCount: futureSynonymList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      child: Center(child: Padding(padding: EdgeInsets.all(8), child: ListTile(leading: Icon(Icons.delete)))),
                      color: Colors.red,
                    ),
                    secondaryBackground: Container(
                      child: Center(child: Padding(padding: EdgeInsets.all(8), child: ListTile(trailing: Icon(Icons.delete)))),
                      color: Colors.red,
                    ),
                    onDismissed: (direction) {
                      serviceData.deleteData(model: _model, id: futureSynonymList[index].id);
                      futureSynonymList.removeAt(index);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: Icon(Icons.description),
                        title: Text(futureSynonymList[index].word),
                        subtitle: Text(
                          futureSynonymList[index].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        modelName: Model.values[0].convert(Model.values[0]).toUpperCase(),
                                        text: futureSynonymList[index].synonym,
                                      )));
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Text('Error'); // error
        }
        return Center(child: CircularProgressIndicator()); // loading
      },
    );
  }

  FutureBuilder<List<dynamic>> buildTranslateView(Service serviceData) {
    List<Translate> futureTranslateList;
    return FutureBuilder(
      future: _translateData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          futureTranslateList = snapshot.data;
          if (snapshot.data != null) {
            if (futureTranslateList.isEmpty) {
              return ListView(children: [Center(child: Text('EEEEEEEMMMPTY'))]);
            } else {
              return ListView.builder(
                primary: true,
                itemCount: futureTranslateList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      child: Center(child: Padding(padding: EdgeInsets.all(8), child: ListTile(leading: Icon(Icons.delete)))),
                      color: Colors.red,
                    ),
                    secondaryBackground: Container(
                      child: Center(child: Padding(padding: EdgeInsets.all(8), child: ListTile(trailing: Icon(Icons.delete)))),
                      color: Colors.red,
                    ),
                    onDismissed: (direction) {
                      serviceData.deleteData(model: _model, id: futureTranslateList[index].id);
                      futureTranslateList.removeAt(index);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: Icon(Icons.description),
                        title: Text(futureTranslateList[index].english),
                        subtitle: Text(
                          futureTranslateList[index].id.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        modelName: Model.values[1].convert(Model.values[1]).toUpperCase(),
                                        text: futureTranslateList[index].turkish,
                                      )));
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Text(snapshot.error.toString()); // error
        }
        return Center(child: CircularProgressIndicator()); // loading
      },
    );
  }
}
