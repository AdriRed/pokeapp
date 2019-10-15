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
  List<PokemonType> types;
  String name;
  String region;
  String description;
  String _imageUrl;

  Pokemon(String name, String region, String description, List<PokemonType> types) {
    this.name = name;
    this.description = description;
    this.region = region;
    this.types = types;
  }

  Pokemon.noDescription(String name, String region, List<PokemonType> types) : this(name, region, "none", types);

  String getImageUrl() {
    return _imageUrl;
  }

  Future setImageUrl() async {
    if (_imageUrl != null) return;

    HttpClient http = new HttpClient();
    try {
      var uri =
          new Uri.http('pokeapi.co', '/api/v2/pokemon/' + name.toLowerCase());
      var request = await http.getUrl(uri);
      var response = await request.close();

      var responseBody = await response.transform(utf8.decoder).join();
      var decoded = json.decode(responseBody);

      var url = decoded["sprites"]["front_default"];
      log(url);
      _imageUrl = url;
    } catch (exception) {
      var uri = new Uri.http('pokeapi.co', '/api/v2/item/poke-ball');
      var request = await http.getUrl(uri);
      var response = await request.close();

      var responseBody = await response.transform(utf8.decoder).join();
      var decoded = json.decode(responseBody);

      var url = decoded["sprites"]["default"];
      _imageUrl = url;
    }
  }
}
