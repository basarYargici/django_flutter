import 'package:flutter/material.dart';
import 'package:local_host_workspace/model/synonym_model.dart';
import 'package:local_host_workspace/screens/add_synonym_screen.dart';
import 'package:local_host_workspace/screens/detail_screen.dart';
import 'package:local_host_workspace/service/synonym_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  List<Synonym> futureData;

  // Future _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _future = Service().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Django backend and flutter frontend",
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Service().getData(),
        builder: (context, snapshot) {
          futureData = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              primary: true,
              itemCount: futureData.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      futureData.removeAt(index);
                    });
                  },
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
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddSynonymScreen()));
        },
      ),
    );
  }
}
