import 'package:flutter/material.dart';
import 'dog_detail_page.dart';
import 'dog_model.dart';

class DogCard extends StatefulWidget {
  final Dog dog;
  DogCard(this.dog);
  @override
  DogCardState createState() {
    return new DogCardState(dog);
  }
}

class DogCardState extends State<DogCard> {
  Dog dog;
  String renderUrl;
  DogCardState(this.dog);
  void initState() {
    super.initState();
  }

  bool _didChangeDependencies = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('DogCard - didChangeDependencies');
    if (!_didChangeDependencies) {
      _didChangeDependencies = true;
      renderDogPic();
    }
  }

  void renderDogPic() async {
    await dog.getImageUrl();
    setState(() {
      renderUrl = dog.imageUrl;
    });
  }

  Widget get dogImage {
    var dogAvatar = new Hero(
      tag: dog,
      child: new Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new NetworkImage(renderUrl ?? ''),
          ),
        ),
      ),
    );

    var placeholder = new Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
          ),
        ),
        alignment: Alignment.center,
        child: new Text(
          'DOGGO',
          textAlign: TextAlign.center,
        ));

    var crossFade = new AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: dogAvatar,
      crossFadeState: renderUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 2000),
    );

    return crossFade;
  }

  Widget get dogCard {
    return new Positioned(
      right: 0.0,
      child: new Container(
        width: 290.0,
        height: 115.0,
        child: new Card(
          color: Colors.white,
          child: new Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 64.0,
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text(widget.dog.name,
                    style: TextStyle(color: Colors.red,fontSize: 25.0,
                        fontWeight: FontWeight.bold)),
                new Text(widget.dog.location,
                    style: TextStyle(color: Colors.black,fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.star,
                      size: 20.0,
                    ),
                    new Text(': ${widget.dog.rating} / 10',
                      style: TextStyle(color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showDogDetailPage(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: new Container(
          height: 115.0,
          child: new Stack(
            children: <Widget>[
              dogCard,
              new Positioned(top: 7.5,left: 5.0, child: dogImage),
            ],
          ),
        ),
      ),
    );
  }

  showDogDetailPage() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new DogDetailPage(dog);
    }));
  }
}