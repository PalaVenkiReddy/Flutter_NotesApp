import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Card,
        Colors,
        EdgeInsets,
        FloatingActionButton,
        Icon,
        IconButton,
        Icons,
        Key,
        ListTile,
        ListView,
        MaterialPageRoute,
        Navigator,
        Scaffold,
        State,
        StatefulWidget,
        SystemMouseCursors,
        Text,
        TextStyle,
        Widget;
import 'package:flutter/painting.dart';
import 'package:notesapp/operations/add.dart';
import 'package:notesapp/database/database.dart';
import 'package:notesapp/operations/edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Database db;
  List docs = [];
  // to initialise the object db
  initialise() {
    db = Database();
    db.initialise();
    db.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text(
          'Notes App',
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.white,
              margin: const EdgeInsets.all(10.0),
              child: ListTile(
                  textColor: Colors.grey,
                  //autofocus: true,
                  //hoverColor: Colors.grey,
                  onTap: () {},
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(
                    docs[index]['title'],
                    style: const TextStyle(
                        fontSize: 25.0, color: Colors.redAccent),
                  ),
                  subtitle: Text(
                    docs[index]['description'],
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  trailing: IconButton(
                      mouseCursor: SystemMouseCursors.cell,
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Edit(notes: docs[index], db: db)))
                            .then((value) => {
                                  if (value != null) {initialise()}
                                });
                      },
                      tooltip: "Edit",
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blueAccent,
                      ))),
            );
          }),
      floatingActionButton: FloatingActionButton(
        //foregroundColor: Colors.red,
        //elevation: 50.0,
        backgroundColor: Colors.pink,
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Add(db: db)))
              .then((value) => {
                    if (value != null) {initialise()}
                  });
        },
        child: const Icon(
          Icons.add,
          color: Colors.blue,
          size: 35.0,
        ),
      ),
    );
  }
}
