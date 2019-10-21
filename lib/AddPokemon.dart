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

  void _addPokemon(context) {
    if (nameController.text.isEmpty || selectedType1 == null) {
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          backgroundColor: Colors.redAccent,
          content: new Text('Pokemon need names!'),
        ),
      );
    } else {
      List<PokemonType> types = new List();
      types.add(selectedType1);
      if (selectedType2 != null) types.add(selectedType2);

      Pokemon newPoke = new Pokemon(
          nameController.text.trim(),
          regionController.text.trim(),
          descriptionController.text.trim(),
          types);
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

  PokemonType selectedType1;
  PokemonType selectedType2;

  List<DropdownMenuItem<PokemonType>> get _items {
    return PokemonType.values
        .map((x) =>
            new DropdownMenuItem(
              value: x, 
              child: new Text(Pokemon.typeToString(x))
              )
            )
        .toList();
  }

  Widget get _types {
    return new Container(
        margin: EdgeInsets.all(10),
        child: new Card(
          color: Color.fromARGB(255, 190, 190, 190),
          child: new Container(
            child: new Column(
              children: <Widget>[
                _pokemonType1,
                _pokemonType2
              ],
            )
          )
        )
    );
  }

  Widget get _pokemonType1 {
    return new Container(
        margin: EdgeInsets.all(10),
        child: new Card(
            color: Color.fromARGB(255, 190, 190, 190),
            child: new Container(
              padding: EdgeInsets.all(8),
              child: new DropdownButton<PokemonType>(
                value: selectedType1,
                onChanged: (newValue) => setState(() => selectedType1 = newValue),
                items: _items,
                hint: Text("1 - Pokemon Type", style: new TextStyle(color: Colors.black)),
                style: new TextStyle(color: Colors.black),
              )
          )
        )
    );
  }

  Widget get _pokemonType2 {
    var items = _items;
    items.add(new DropdownMenuItem<PokemonType>(
      value: null,
      child: new Text(" -------- ")
    ));
    return new Container(
        margin: EdgeInsets.all(10),
        child: new Card(
            color: Color.fromARGB(255, 190, 190, 190),
            child: new Container(
              padding: EdgeInsets.all(8),
              child: new DropdownButton<PokemonType>(
                onChanged: (newValue) => setState(() => selectedType2 = newValue),
                items: items,
                hint: Text("2 - Pokemon Type", style: new TextStyle(color: Colors.black)),
                style: new TextStyle(color: Colors.black),
            )
          )
        )
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
    form.add(_types);
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
        child: Icon(Icons.check, color: Colors.black),
        onPressed: () => _addPokemon(context),
        backgroundColor: Colors.white,
      ),
    );
  }
}
