import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:developer';

enum PokemonType {
  Normal,
  Fighting,
  Flying,
  Poison,
  Ground,
  Rock,
  Bug,
  Ghost,
  Steel,
  Fire,
  Water,
  Grass,
  Electric,
  Psychic,
  Ice,
  Dragon,
  Dark,
  Fairy,
  Unknown,
  Shadow
}


class Pokemon {
  final List<String> types;
  final String name;
  final String description;
  final String region;
  String imageUrl;

  Pokemon(this.name, this.description, this.region, this.types);

  Future getImageUrl() async {
    if (imageUrl != null) return;

    HttpClient http = new HttpClient();
    try {
      var uri = new Uri.http('pokeapi.co', '/api/v2/pokemon/' + name.toLowerCase());
      var request = await http.getUrl(uri);
      var response = await request.close();
      
      var responseBody = await response.transform(utf8.decoder).join();
      var decoded = json.decode(responseBody);
      
      var url = decoded["sprites"]["front_default"];
      log(url);
      imageUrl = url;
    } catch (exception) {
      var uri = new Uri.http('pokeapi.co', '/api/v2/item/poke-ball');
      var request = await http.getUrl(uri);
      var response = await request.close();
      
      var responseBody = await response.transform(utf8.decoder).join();
      var decoded = json.decode(responseBody);

      var url = decoded["sprites"]["default"];
      imageUrl = url;
    }
  }
}