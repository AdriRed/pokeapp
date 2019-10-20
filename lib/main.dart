import 'package:flutter/material.dart';
import 'package:pokeapp/AddPokemon.dart';
import 'PokemonList.dart';
import 'Pokemon.dart';
import 'presentation/custom_icons_icons.dart';

void main() {
  runApp(new PokemonApp());
}

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Pokemon",
        theme: new ThemeData(brightness: Brightness.dark),
        home: new PokemonHomePage(title: "Pokemon"));
  }
}

class PokemonHomePage extends StatefulWidget {
  PokemonHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PokemonHomePageState createState() => new _PokemonHomePageState();
}

class _PokemonHomePageState extends State<PokemonHomePage> {
  var pokemonlist = <Pokemon>[]
    ..add(new Pokemon.noDescription(
        "Pikachu", "Kanto", <PokemonType>[PokemonType.Electric]))
    ..add(new Pokemon.noDescription("Rayquaza", "Kanto",
        <PokemonType>[PokemonType.Normal, PokemonType.Bug]))
    ..add(new Pokemon.noDescription(
        "Arceus", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon.noDescription(
        "Torterra", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon.noDescription(
        "Ditto", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon.noDescription(
        "Chimchar", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon.noDescription(
        "Treecko", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(new Pokemon.noDescription(
        "Don Patricio", "Kanto", <PokemonType>[PokemonType.Normal]))
    ..add(
        new Pokemon.noDescription("Charmander", "Kanto", <PokemonType>[PokemonType.Normal]));

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
          backgroundColor: Colors.red, title: new Text(widget.title)),
      body: new Container(
        color: Colors.white70,
        child: new Center(
          child: new PokemonList(pokemonlist),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CustomIcons.addPoke),
        onPressed: () => _showNewPokemonForm(),
        backgroundColor: Colors.white,
      ),
    );
  }

  Future<Null> _showNewPokemonForm() async {
    Pokemon newPoke = await Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new AddPokemonFormPage();
        },
      ),
    );

    if (newPoke != null) 
      if (!pokemonlist.any((pk) => pk.name == newPoke.name))
        pokemonlist.add(newPoke);
      else {
      //   Scaffold.of(context).showSnackBar(
      //   new SnackBar(
      //     backgroundColor: Colors.redAccent,
      //     content: new Text(newPoke.name + " already exists!"),
      //   ),
      // );
      }
  }
}
