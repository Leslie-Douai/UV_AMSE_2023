import 'package:flutter/material.dart';

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
        GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          shrinkWrap: true,
          crossAxisCount: 3,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(4),
              child: this.createTileWidgetFrom(tile),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: this.createTileWidgetFrom(Tile(
                  imageURL: 'assets/images/pic.jpeg',
                  alignment: Alignment(0, -1))),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: this.createTileWidgetFrom(Tile(
                  imageURL: 'assets/images/pic.jpeg',
                  alignment: Alignment(1, -1))),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: this.createTileWidgetFrom(Tile(
                  imageURL: 'assets/images/pic.jpeg',
                  alignment: Alignment(-1, 0))),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: this.createTileWidgetFrom(Tile(
                  imageURL: 'assets/images/pic.jpeg',
                  alignment: Alignment(0, 0))),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: this.createTileWidgetFrom(Tile(
                  imageURL: 'assets/images/pic.jpeg',
                  alignment: Alignment(1, 0))),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: this.createTileWidgetFrom(Tile(
                  imageURL: 'assets/images/pic.jpeg',
                  alignment: Alignment(-1, 1))),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: this.createTileWidgetFrom(Tile(
                  imageURL: 'assets/images/pic.jpeg',
                  alignment: Alignment(0, 1))),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: this.createTileWidgetFrom(Tile(
                  imageURL: 'assets/images/pic.jpeg',
                  alignment: Alignment(1, 1))),
            ),
          ],
        ),
        Container(
            height: 200,
            child: Image.network('assets/images/pic.jpeg', fit: BoxFit.cover))
      ])),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({this.imageURL, this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

Tile tile =
    new Tile(imageURL: 'assets/images/pic.jpeg', alignment: Alignment(-1, -1));
