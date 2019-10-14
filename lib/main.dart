import 'package:flutter/material.dart';
import 'package:we_rate_dogs/PokemonList.dart';
import 'Pokemon.dart';

void main() {
  runApp(new PokemonApp());
}

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Pokemooon",
      theme: new ThemeData(brightness: Brightness.dark),
      home: new PokemonHomePage(title: "Pokemooon")
    );
  }
}

class PokemonHomePage extends StatefulWidget {
  PokemonHomePage({Key key, this.title}) : super(key:key);
  
  final String title;

  @override
  _PokemonHomePageState createState() => new _PokemonHomePageState();
}

class _PokemonHomePageState extends State<PokemonHomePage> {
  var initialPokemon = <Pokemon>[]
    ..add(new Pokemon("Pikachu", "Kanto", <PokemonType>[PokemonType.Electric]))
    ..add(new Pokemon("Rayquaza", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon("Arceus", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon("Torterra", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon("Ditto", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon("Chimchar", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon("Treeko", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon("Don Patricio", "Kanto", <PokemonType>[PokemonType.Normal]));
  
  @override
  Widget build(BuildContext context) {  
    var key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text(widget.title)
      ),
      body: new Container(
        color: Colors.white70,
        child: new Center(
          child: new PokemonList(initialPokemon),
        ),
      ),
    );
  }
}