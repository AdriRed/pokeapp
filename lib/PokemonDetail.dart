import 'package:flutter/material.dart';
import 'Pokemon.dart';
import 'dart:developer';

class PokemonDetail extends StatefulWidget {
  final Pokemon pokemon;

  PokemonDetail(this.pokemon);

  @override
  _PokemonDetailPageState createState() => new _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetail> {
  double pokemonAvatarSize = 100;

  List<Widget> get pokemonData {
    List<Widget> data = new List();
    data.add(new Text("POKEMON " + widget.pokemon.name));
    for (var type in widget.pokemon.types) {
      data.add(new Text("TYPE: " + type));
    }
    return data;
  }

  Widget get pokemonDetails {
    
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: pokemonData,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text(widget.pokemon.name)
      ),
      body: new ListView(
        children: <Widget>[pokemonDetails],
      )
    );
  }
}