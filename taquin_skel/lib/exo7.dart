import 'package:flutter/material.dart';
import 'dart:math' as math;

math.Random random = new math.Random();

int Xtouch = 2;
int Ytouch = 2;

Tile tile =
    new Tile(imageURL: 'assets/images/pic.jpeg', alignment: Alignment(-1, -1));

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Find the right path'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(children: [
          TaquinTransform(), //Ici
        ])));
  }
}

class TaquinTransform extends StatefulWidget {
  @override
  _TaquinTransformState createState() => _TaquinTransformState();
}

class _TaquinTransformState extends State<TaquinTransform> {
  double _taille = 3.0;
  List<Widget> _tiles = [];
  List<int> listPosition = [];
  int indexBlank = 2;
  int lastChange = 0;
  bool shuff = false;
  int coup = 0;

  @override
  void initState() {
    indexBlank = random.nextInt((_taille * _taille).toInt());
    _tiles = generateCroppedTileList(_taille.toInt(), Xtouch, Ytouch);
    listPosition =
        List.generate(_taille.toInt() * _taille.toInt(), (index) => index);
    //_tiles.shuffle();
    _tiles[indexBlank] =
        Tile(alignment: Alignment(0, 0)).BlankTile(_taille.toInt());
    shuffleTaquin();
    coup = 0;
  }

  _changeTaille() {
    indexBlank = random.nextInt((_taille * _taille).toInt());
    _tiles = generateCroppedTileList(_taille.toInt(), Xtouch, Ytouch);
    listPosition =
        List.generate(_taille.toInt() * _taille.toInt(), (index) => index);
    //_tiles.shuffle();
    _tiles[indexBlank] =
        Tile(alignment: Alignment(0, 0)).BlankTile(_taille.toInt());
    shuffleTaquin();
  }

  shuffleTaquin() {
    shuff = true;
    for (var k = 0; k < _taille * _taille; k++) {
      List index = [
        indexBlank - _taille,
        indexBlank - 1,
        indexBlank + 1,
        indexBlank + _taille
      ];
      index.removeWhere(
          (element) => element < 0 || element > _taille * _taille - 1);
      _onTapTile(index[random.nextInt(index.length)]);
    }

    shuff = false;
    coup = 0;
  }

  setShuffleDifficulty(int diff) {
    shuff = true;
    for (var k = 0; k < diff; k++) {
      List index = [
        indexBlank - _taille,
        indexBlank - 1,
        indexBlank + 1,
        indexBlank + _taille
      ];
      index.removeWhere(
          (element) => element < 0 || element > _taille * _taille - 1);
      _onTapTile(index[random.nextInt(index.length)]);
    }

    shuff = false;
    coup = 0;
  }

  bool possible(int x) {
    return [
      indexBlank - _taille,
      indexBlank - 1,
      indexBlank + 1,
      indexBlank + _taille
    ].contains(x);
    //[0, 1, -1].contains((x % _taille) - (y % _taille));
  }

  _onTapTile(int index) {
    //print("Blank :" + indexBlank.toString() + "/ Tap :" + index.toString());

    if (possible(index)) {
      _tiles.insert(indexBlank, _tiles.removeAt(index));
      listPosition.insert(indexBlank, listPosition.removeAt(index));
      indexBlank > index
          ? _tiles.insert(index, _tiles.removeAt(indexBlank - 1))
          : _tiles.insert(index, _tiles.removeAt(indexBlank + 1));
      indexBlank > index
          ? listPosition.insert(index, listPosition.removeAt(indexBlank - 1))
          : listPosition.insert(index, listPosition.removeAt(indexBlank + 1));

      if (!shuff) {
        lastChange = indexBlank;
      }
      indexBlank = index;
      coup++;

      // print(
      //     "NewBlank :" + indexBlank.toString() + "/ Tap :" + index.toString());
      // print("_______");

      if (!shuff && win()) {
        _showWinDialog(context);
        shuffleTaquin();
        coup = 0;
      }
      setState(() {});
    }
  }

  bool win() {
    for (var k = 0; k < listPosition.length; k++) {
      if (listPosition[k] != k) {
        return false;
      }
    }
    return true;
  }

  _undo() {
    _onTapTile(lastChange);
  }

  _showWinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bravo!'),
          content: Text('The lord has been fix!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Column(children: [
      GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        shrinkWrap: true,
        crossAxisCount: _taille.toInt(),
        children: _tiles
            .map((tile) => Padding(
                  padding: EdgeInsets.all(0.4),
                  child: InkWell(
                    child: tile,
                    onTap: () => _onTapTile(_tiles.indexOf(tile)),
                  ),
                ))
            .toList(),
      ),
      Slider(
        value: _taille,
        min: 2,
        max: 12,
        divisions: 10,
        onChanged: (value) {
          setState(() {
            _taille = value;
            _changeTaille();
          });
        },
      ),
      Text("Coups : $coup"),
      ElevatedButton(
        onPressed: () => setState(() {
          coup++;
          _undo();
        }),
        child: Text("Undo"),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(
          onPressed: () {
            setShuffleDifficulty((_taille * _taille).toInt());
          },
          child: Text('Easy'),
        ),
        ElevatedButton(
          onPressed: () {
            setShuffleDifficulty(
                (_taille * _taille * _taille * _taille).toInt());
          },
          child: Text('Medium'),
        ),
        ElevatedButton(
          onPressed: () {
            setShuffleDifficulty(
                (_taille * _taille * _taille * _taille * _taille * _taille)
                    .toInt());
          },
          child: Text('Hard'),
        )
      ]),
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

  Widget BlankTile(int taille) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 1 / taille,
            heightFactor: 1 / taille,
            child: Container(
                color: Color.fromARGB(255, random.nextInt(255),
                    random.nextInt(255), random.nextInt(255)),
                child: Padding(
                  padding: EdgeInsets.all(70.0),
                )),
          ),
        ),
      ),
    );
  }
}

List<Widget> generateCroppedTileList(int taille, int xtouch, int ytouch) {
  List<Widget> l = [];

  for (var y = 1; y < taille + 1; y++) {
    for (var x = 1; x < taille + 1; x++) {
      double Align_x = (((x - 1) * (2)) / (taille - 1)) - 1;
      double Align_y = (((y - 1) * (2)) / (taille - 1)) - 1;

      // if (y != ytouch || x != xtouch) {
      l.add(Padding(
        padding: EdgeInsets.all(0.4),
        child: InkWell(
          child: Tile(alignment: Alignment(Align_x, Align_y))
              .croppedImageTile(taille),
        ),
      ));
      // } else {
      //   l.add(Padding(
      //     padding: EdgeInsets.all(0.4),
      //     child: InkWell(
      //       child:
      //           Tile(alignment: Alignment(Align_x, Align_y)).BlankTile(taille),
      //       // onTap: () {
      //       //   if ([0, -1, 1].contains(xtouch - x) &&
      //       //       [0, -1, 1].contains(ytouch - y)) {
      //       //     setState(() {
      //       //       Xtouch = x;
      //       //       Ytouch = y;
      //       //     });
      //       //   }
      //       // },
      //     ),
      //   ));
      // }
    }
  }

  return l;
}
