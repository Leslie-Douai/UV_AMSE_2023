import 'package:flutter/material.dart';
import 'dart:math';

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Crop the lord'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(children: [
          TaquinTransform(),
          Container(
              height: 200,
              child:
                  Image.network('assets/images/pic.jpeg', fit: BoxFit.cover)),
        ])));
  }
}

class TaquinTransform extends StatefulWidget {
  @override
  _TaquinTransformState createState() => _TaquinTransformState();
}

class _TaquinTransformState extends State<TaquinTransform> {
  double _taille = 3.0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        shrinkWrap: true,
        crossAxisCount: _taille.toInt(),
        children: generateCroppedTileList(_taille.toInt()),
      ),
      Slider(
        value: _taille,
        min: 2,
        max: 12,
        onChanged: (value) {
          setState(() {
            _taille = value;
          });
        },
      )
    ]);
  }
}

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({this.imageURL = 'assets/images/pic.jpeg', this.alignment});

  Widget croppedImageTile(int taille) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 1 / taille,
            heightFactor: 1 / taille,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

List<Widget> generateCroppedTileList(int taille) {
  List<Widget> l = [];

  for (var y = 1; y < taille + 1; y++) {
    for (var x = 1; x < taille + 1; x++) {
      double Align_x = (((x - 1) * (2)) / (taille - 1)) - 1;
      double Align_y = (((y - 1) * (2)) / (taille - 1)) - 1;

      l.add(Padding(
        padding: EdgeInsets.all(0.4),
        child: InkWell(
          child: Tile(alignment: Alignment(Align_x, Align_y))
              .croppedImageTile(taille),
          onTap: () {
            print("tapped on tile");
          },
        ),
      ));
    }
  }

  return l;
}

Tile tile =
    new Tile(imageURL: 'assets/images/pic.jpeg', alignment: Alignment(-1, -1));
