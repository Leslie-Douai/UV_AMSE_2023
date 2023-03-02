import 'package:flutter/material.dart';

// import 'util.dart';
import 'exo1.dart' as exo1;
import 'exo2.dart' as exo2;
import 'exo4.dart' as exo4;
import 'exo5.dart' as exo5;
import 'exo5b.dart' as exo5b;
import 'exo6.dart' as exo6;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UV-AMSE-Flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
      ),
      home: MenuPage(),
    );
  }
}

class Exo {
  final String title;
  final String subtitle;
  final WidgetBuilder buildFunc;

  const Exo({@required this.title, this.subtitle, @required this.buildFunc});
}

List exos = [
  Exo(
      title: 'Exercice 1',
      subtitle: 'Simple image',
      buildFunc: (context) => exo1.DisplayImageWidget()),
  Exo(
      title: 'Exercice 2',
      subtitle: 'Rotate&Scale image',
      buildFunc: (context) => exo2.DisplayImageWidget()),
  Exo(
      title: 'Exercice 4',
      subtitle: 'Lets crop the lord',
      buildFunc: (context) => exo4.DisplayImageWidget()),
  Exo(
      title: 'Exercice 5',
      subtitle: 'Lets divide the lord',
      buildFunc: (context) => exo5.DisplayImageWidget()),
  Exo(
      title: 'Exercice 5b',
      subtitle: 'The lord is divided',
      buildFunc: (context) => exo5b.DisplayImageWidget()),
  Exo(
      title: 'Exercice 6',
      subtitle: 'I like to move it',
      buildFunc: (context) => exo6.DisplayImageWidget()),
];

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ThéPaix II'),
        ),
        body: ListView.builder(
            itemCount: exos.length,
            itemBuilder: (context, index) {
              var exo = exos[index];
              return Card(
                  child: ListTile(
                      title: Text(exo.title),
                      subtitle: Text(exo.subtitle),
                      trailing: Icon(Icons.play_arrow_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: exo.buildFunc),
                        );
                      }));
            }));
  }
}
