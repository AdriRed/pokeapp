import 'package:flutter/material.dart';
import 'Pokemon.dart';
import 'dart:developer';

class PokemonDetail extends StatefulWidget {
  final Pokemon pokemon;

  PokemonDetail(this.pokemon);

  @override
  _PokemonDetailPageState createState() => new _PokemonDetailPageState(pokemon);
}

class _PokemonDetailPageState extends State<PokemonDetail> {
  double pokemonAvatarSize = 150;
  String renderUrl;

  Pokemon pokemon;
  _PokemonDetailPageState(Pokemon pk) {
    pokemon = pk;
  }

  void initState() {
		super.initState();
		renderPokemonPic();
	}

	void renderPokemonPic() async {
		await pokemon.setImageUrl();
		if (this.mounted)
			setState(() {
				renderUrl = pokemon.getImageUrl();
		});
	}

  Widget get pokemonImage {
    var imageAvatar = new Hero(
      tag: pokemon.name + "_AV",
      child: new Container(
        width: pokemonAvatarSize,
        height: pokemonAvatarSize,
        child: new Image(
            fit: BoxFit.fill,
            image: NetworkImage(renderUrl ?? ""),
            filterQuality: FilterQuality.none),
      ),
    );

    var placeholder = new Hero(
      tag: pokemon.name + "_PH",
      child: new Container(
        width: 160.0,
        height: 160.0,
        child: new Image(
            fit: BoxFit.fill,
            image: AssetImage("assets/poke-ball.png"),
            filterQuality: FilterQuality.none),
      ),
    );

    var crossFade = new AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: imageAvatar,
      crossFadeState: renderUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  List<Widget> get pokemonData {
    List<Widget> data = new List();
    data.add(pokemonImage);
    data.add(new Text("POKEMON " + widget.pokemon.name));
    for (var type in widget.pokemon.types) {
      data.add(new Text("TYPE: " + type.toString()));
    }
    return data;
  }

  Widget get pokemonDetails {
    return new Container(
        padding: new EdgeInsets.symmetric(vertical: 32.0),
        child: new Column (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: pokemonData
          )
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black,
        appBar: new AppBar(
            backgroundColor: Colors.red, title: new Text(widget.pokemon.name)),
        body: new ListView(
          children: <Widget>[pokemonDetails],
        ));
  }
}
