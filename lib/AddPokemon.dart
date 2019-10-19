import 'package:flutter/material.dart';
import 'Pokemon.dart';

class AddPokemonFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AddPokemonFormPageState();
  }
}

class _AddPokemonFormPageState extends State<AddPokemonFormPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController regionController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  void _addPokemon(BuildContext context) {
    if (nameController.text.isEmpty) {
      
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          backgroundColor: Colors.redAccent,
          content: new Text('Pokemon need names!'),
        ),
      );
    } else {
      Pokemon newPoke = new Pokemon(nameController.text.trim(),
          regionController.text.trim(), descriptionController.text.trim(), <PokemonType>[PokemonType.Normal]);
      Navigator.of(context).pop(newPoke);
    }

    print("CREATE POKEMON!");
  }

  Widget _customTxtF(TextEditingController controller, [String label]) {
    return new Hero(
      tag: controller,
      child: new TextField(
        controller: controller,
        decoration: new InputDecoration(
            labelText: label,
            labelStyle: new TextStyle(color: Colors.black),
            border: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.red))),
        onTap: () => print("TAP"),
        onEditingComplete: () => print("COMPLETE"),
        onChanged: (txt) => print("CHANGED => " + txt),
      ),
    );
  }

  Widget get _pokemonName {
    return new Container(
        margin: EdgeInsets.all(10),
        child: new Card(
            color: Color.fromARGB(255, 190, 190, 190),
            child: new Container(
                padding: const EdgeInsets.all(15),
                child: _customTxtF(nameController, "Pokemon Name"))));
  }

  Widget get _pokemomRegion {
    return new Container(
        margin: EdgeInsets.all(10),
        child: new Card(
            color: Color.fromARGB(255, 190, 190, 190),
            child: new Container(
                padding: const EdgeInsets.all(15),
                child: _customTxtF(regionController, "Pokemon Region"))));
  }

  Widget get _pokemonDescription {
    return new Container(
        margin: EdgeInsets.all(10),
        child: new Card(
            color: Color.fromARGB(255, 190, 190, 190),
            child: new Container(
                padding: const EdgeInsets.all(15),
                child: _customTxtF(
                    descriptionController, "Pokemon Description"))));
  }

  List<Widget> get _form {
    List<Widget> form = new List();
    form.add(_pokemonName);
    form.add(_pokemomRegion);
    form.add(_pokemonDescription);
    return form;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.red, title: new Text("Add pokemon")),
      body: new Container(
        color: Colors.white70,
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 32.0,
        ),
        child: new ListView(
          shrinkWrap: true,
          children: _form,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () => _addPokemon(context),
        backgroundColor: Colors.white,
      ),
    );
  }
}
