import 'package:flutter/material.dart';

import 'dog_model.dart';

class DogAddForm extends StatefulWidget {
  @override
  _DogAddFormState createState() => _DogAddFormState();
}

class _DogAddFormState extends State<DogAddForm> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController descreptionController = new TextEditingController();
  void submit(context) {
    if (nameController.text.isEmpty ||
        locationController.text.isEmpty ||
        descreptionController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Error !'),
      ));
    } else {
      Dog newDog = new Dog(nameController.text, locationController.text,
          descreptionController.text);
      Navigator.of(context).pop(newDog);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new dog '),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        color: Colors.black45,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Dog Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: 'Location ',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextField(
                      controller: descreptionController,
                      decoration: InputDecoration(
                        labelText: 'Descreption ',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Builder(
                      builder: (context) {
                        return RaisedButton(
                          color: Colors.redAccent,
                          child: Text('Submit'),
                          onPressed: () {
                            submit(context);
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
