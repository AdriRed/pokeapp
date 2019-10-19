import 'package:flutter/cupertino.dart';
import 'Pokemon.dart';
import 'package:flutter/material.dart';
import 'PokemonDetail.dart';

class PokemonCard extends StatefulWidget {
	final Pokemon pokemon;

	PokemonCard(this.pokemon);

	@override
	PokemonCardState createState() {
		return new PokemonCardState(pokemon);
	}
}

class PokemonCardState extends State<PokemonCard> {
	Pokemon pokemon;
	String renderUrl;
	PokemonDetail detail;

	PokemonCardState(Pokemon pk) {
		pokemon = pk;
		detail = new PokemonDetail(pokemon);
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

	Widget get pokemonCard {
		Widget w =  new Positioned(
			width: 180.0,
			height: 180.0,
			child: new Container(
				child: new Card(
          color: Color.fromARGB(255, 50, 50, 50),
					child: new Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						mainAxisAlignment: MainAxisAlignment.end,
						children: <Widget>[
							new Padding(
								child: new Text(
									widget.pokemon.name, 
									style: Theme.of(context).textTheme.title,
								),
								padding: EdgeInsets.fromLTRB(10, 0, 0, 10)
							),
						]
						),
					),
				),
		);

		return w;
	}

	Widget get pokemonImage {
		var imageAvatar = new Hero(
			tag: pokemon.name + "_AV_" + TimeOfDay.now().toString(),
			child: new Container(
				width: 160.0,
				height: 160.0,
				child: new Image(
						fit: BoxFit.fill,
						image: NetworkImage(renderUrl ?? ""),
						filterQuality: FilterQuality.none
					),
			),
		);

		var placeholder = new Hero(
			tag: pokemon.name + "_AV_" + TimeOfDay.now().toString(),
			child: new Container(
				width: 160.0,
				height: 160.0,
				child: new Image(
						fit: BoxFit.fill,
						image: AssetImage("assets/poke-ball.png"),
						filterQuality: FilterQuality.none
					),
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

	void showPokemonDetail() {
		Navigator.of(context).push(new MaterialPageRoute(
			builder: (context) 
				{
					return new PokemonDetail(widget.pokemon);
				}
			)  
		);
	}

	@override
	Widget build(BuildContext context) {
		return new InkWell(
			onTap: () => showPokemonDetail(),
			child: new Container(
				height: 180.0,
        margin: EdgeInsets.all(5),
				child: new Stack(
					children: <Widget>[
						pokemonCard,
						new Positioned(top: -5, left: 15,child: pokemonImage)
					],
				),
			),
		);
	}

	
}