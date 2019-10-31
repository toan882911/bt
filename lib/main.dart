import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_learn/dog_add_form.dart';
import 'dog_list.dart';
import 'dog_model.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'We Rate Dogs',
      theme: new ThemeData(brightness: Brightness.light),
      home: new MyHomePage(title: 'We Rate Dogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var initalDog = <Dog>[]
    ..add(new Dog('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'))
    ..add(new Dog('Rex', 'Seattle, WA, USA', 'A Very Good Boy'))
    ..add(new Dog('Rod Stewart', 'Prague, CZ', 'A Very Good Boy'))
    ..add(new Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(new Dog('Buddy', 'North Pole, Earth', 'A Very Good Boy'));
  Future<Null> _showNewDogForm() async {
    Dog newDog = await Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new DogAddForm();
        },
      ),
    );
    if (newDog != null) {
      initalDog.add(newDog);
    }
  }

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text(widget.title),
        actions: [
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: () => _showNewDogForm(),
          ),
        ],
      ),
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo[400],
              Colors.indigo[300],
              Colors.indigo[200],
              Colors.indigo[100],
            ],
          ),
        ),
        child: new Center(
          child: new DogList(initalDog),
        ),
      ),
    );
  }
}
