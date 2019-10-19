import 'package:flutter/material.dart';
import 'Pokemon.dart';
import 'PokemonCard.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemon;

  PokemonList(this.pokemon);

  GridView _buildList(BuildContext context) {
    return new GridView.count(
      crossAxisCount: 2,
      controller: new ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: pokemon.map((x) => new PokemonCard(x)).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}