import 'package:flutter/material.dart';
import 'Pokemon.dart';

class PokemonDetail extends StatefulWidget {
  final Pokemon pokemon;

  PokemonDetail(this.pokemon);

  @override
  _PokemonDetailPageState createState() => new _PokemonDetailPageState(pokemon);
}

class _PokemonDetailPageState extends State<PokemonDetail> {
  var typeColors = <Color>[
    new Color(0xFFa8a878),// Normal,
    new Color(0xFFc03028),// Fighting,
    new Color(0xFFa890f0),// Flying,
    new Color(0xFFa040a0),// Poison,
    new Color(0xFFe0c068),// Ground,
    new Color(0xFFb8a038),// Rock,
    new Color(0xFFa8b820),// Bug,
    new Color(0xFF705898),// Ghost,
    new Color(0xFFb8b8d0),// Steel,
    new Color(0xFFf08030),// Fire,
    new Color(0xFF6890f0),// Water,
    new Color(0xFF78c850),// Grass,
    new Color(0xFFf8d030),// Electric,
    new Color(0xFFf85888),// Psychic,
    new Color(0xFF98d8d8),// Ice,
    new Color(0xFF7038f8),// Dragon,
    new Color(0xFF705848),// Dark,
    new Color(0xFFf0b6bc),// Fairy,
    new Color(0xFF6aa596),// Unknown,
    new Color(0xFF705898)// Shadow
  ];

  double pokemonAvatarSize = 250;
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
        width: pokemonAvatarSize,
        height: pokemonAvatarSize,
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

  List<Widget> get _types {
    List<Widget> types = new List();
    for (var type in widget.pokemon.types) {
      types.add(new Card(
        color: typeColors[PokemonType.values.indexOf(type)],
        child: new Padding(
          padding: EdgeInsets.all(8),
          child: new Text(
            Pokemon.typeToString(type).toUpperCase(), 
            style: new TextStyle(color: Colors.white, fontSize: 15),
          ),
      )));
    }
    return types;
  }

  Widget get _firstRow {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: new Center(child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _name,
          new Column(
            children: _types,
          )
        ],
      ),
      )
      
    );
  }

  Widget get _name {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: 155,
      alignment: Alignment.center,
      child: new Card(
        color: Color.fromARGB(255, 190, 190, 190),
        child: new Padding(
            padding: EdgeInsets.all(8),
            child: new FittedBox(
              fit: BoxFit.contain,
              child: new Text(
                pokemon.name,
                style: TextStyle(fontSize: 30, color: Colors.black),
                textAlign: TextAlign.center,
              )
              ),
        )));
  }

  Widget get _description {
    TextStyle tst = new TextStyle(fontSize: 20, color: Colors.black);
    return new Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: new Card(
            color: Color.fromARGB(255, 190, 190, 190),
            margin: EdgeInsets.all(8),
            child: new Container(
              padding: EdgeInsets.all(8),
              child: new Text(widget.pokemon.description, style: tst))
                  ),
            );
  }

  Widget get _region {
    return new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: new Card(
          color: Color.fromARGB(255, 190, 190, 190),
          child: new Padding(
              padding: EdgeInsets.all(5),
              child: new Text("Region:   " + widget.pokemon.region,
                  style: TextStyle(fontSize: 20, color: Colors.black)))),
    );
  }

  List<Widget> get pokemonData {
    List<Widget> data = new List();
    data.add(new Container(
        child: new Card(
            child: pokemonImage, color: Color.fromARGB(255, 200, 200, 200))));

    data.add(new Container(
        width: 400,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: new Card(
          color: Color.fromARGB(255, 200, 200, 200),
          child: new Container(
            alignment: Alignment.center,
            child: new Column(
              children: _textData,
            )
          ),
        )));
    return data;
  }

  List<Widget> get _textData {
    List<Widget> textData = new List();

    textData.add(_firstRow);
    textData.add(_region);
    if (pokemon.description.length > 0) textData.add(_description);

    return textData;
  }

  Widget get pokemonDetails {
    return new Container(
        padding: new EdgeInsets.symmetric(vertical: 32.0),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: pokemonData));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromARGB(255, 220, 220, 220),
        appBar: new AppBar(
            backgroundColor: Colors.red, title: new Text(widget.pokemon.name)),
        body: new ListView(
          children: <Widget>[pokemonDetails],
        ));
  }
}
