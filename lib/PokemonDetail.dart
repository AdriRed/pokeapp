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
        child: new Padding(
          padding: EdgeInsets.all(8),
          child:new Text(type.toString().toUpperCase().substring(type.toString().indexOf(".")+1), style: new TextStyle(color: Colors.white, fontSize: 15),),
        )
      ));
    }
    return types;
  }

  Row get _firstRow {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        
        new Container(
          width: 200,
          height: 100,
            alignment: Alignment.center,
            child: new Card(
              color: Color.fromARGB(255, 190, 190, 190),
              child: new Padding(
                padding: EdgeInsets.all(8),
                child: new Text(
                  pokemon.name,
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  textAlign: TextAlign.center,
                )
              ),
            )
          ),
        
        new Column(
          children: _types,
        )
      ],
    );
  }

  Widget get _description {
    TextStyle tst = new TextStyle(fontSize: 20, color: Colors.black);
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          alignment: Alignment.topLeft,
            child: new Text("Description: ", style: tst)
        ),
        new Container(
          alignment: Alignment.topLeft,
          child: new Text(widget.pokemon.description, style: tst)
        )
      ]
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
          child: new Column(
            children: <Widget>[
              _firstRow,
              new Container(
                child: new Card(
                  color: Color.fromARGB(255, 190, 190, 190),
                  child: new Padding(
                    padding: EdgeInsets.all(5),
                    child: new Text(
                      "Region:   " + widget.pokemon.region, 
                      style:TextStyle(fontSize: 20, color: Colors.black)
                    )
                  )
                ),
              ),
              _description
            ],
          ),
        )));
    //data.add(new Text(widget.pokemon.name, style: TextStyle(fontSize: 32, color: Colors.black)));
    return data;
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
