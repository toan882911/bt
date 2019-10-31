import 'package:flutter/material.dart';
import 'dart:async';
import 'dog_model.dart';

class DogDetailPage extends StatefulWidget {
  final Dog dog;
  DogDetailPage(this.dog);
  @override
  _DogDetailPageState createState() => _DogDetailPageState();
}

class _DogDetailPageState extends State<DogDetailPage> {
  double dogAvatarSize = 150.0;
  double _slideValue = 10.0;
  Widget get doImage{
    return Hero(
      tag: widget.dog,
      child: Container(
        height: dogAvatarSize,
        width: dogAvatarSize,
        constraints: BoxConstraints(),
        decoration:  BoxDecoration(
          shape: BoxShape.circle,
          boxShadow:[
            BoxShadow(
              offset: Offset(1.0,2.0),
              blurRadius: 2.0,
              spreadRadius: -1.0,
              color: Color(0x33000000)
            ),
            BoxShadow(
              offset: Offset(2.0,1.0),
              blurRadius: 3.0,
              spreadRadius: 0.0,
              color: Color(0x24000000),
            ),
            BoxShadow(
              offset: Offset(3.0,1.0),
              blurRadius: 4.0,
              spreadRadius: 2.0,
              color: Color(0x1F000000),
            ),
          ],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.dog.imageUrl ?? ''),
          )
        ),
      )
    );
  }

  Widget get dogProfile{
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1,0.5,0.7,0.9],
          colors: [
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ]
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          doImage,
          Text(
            widget.dog.name + ' 🎾',
            style: TextStyle(fontSize: 30.0),
          ),
          Text(
            widget.dog.location,
            style: TextStyle(fontSize: 20.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0,vertical: 16.0),
            child: Text(widget.dog.description),
          ),
          rating,
        ],
      ),
    );
  }

  Widget get rating{
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          size: 40.0,
        ),
        Text(
          '${widget.dog.rating}/10',
          style: Theme.of(context).textTheme.display2,
        )
      ],
    );
  }

  Widget get addYourRating{
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newRating) =>updateSlider(newRating),
                  value: _slideValue,
                ),
              ),
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text('${_slideValue.toInt()}',style: TextStyle(fontSize: 25.0),),
              )
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateSlider(double newRating) {
    setState(() => _slideValue = newRating);
  }

  Widget get submitRatingButton{
    return RaisedButton(
      color: Colors.indigoAccent,
      child: Text('Submit'),
      onPressed: updateRating,
    );
  }

  void updateRating(){
    if(_slideValue <10){
      _ratingErrorDialog();
    }else{
      setState(() {
        widget.dog.rating = _slideValue.toInt();
      });
    }
  }

  Future<Null> _ratingErrorDialog() async {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Error!'),
        content: Text("They're good dogs ,Brant "),
        actions: <Widget>[
          FlatButton(
            child: Text('Try again'),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Meet ${widget.dog.name}'),
      ),
      body: ListView(
        children: <Widget>[
          dogProfile,
          addYourRating,
        ],
      ),
    );
  }
}

