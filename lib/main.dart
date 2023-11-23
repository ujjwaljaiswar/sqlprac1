import 'package:flutter/material.dart';
import 'Animal.dart';
import 'DatabaseHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animal List'),
          centerTitle: true,
          backgroundColor: Colors.yellow,
        ),
        body: AnimalList(),
      ),
    );
  }
}

class AnimalList extends StatefulWidget {
  @override
  _AnimalListState createState() => _AnimalListState();
}

class _AnimalListState extends State<AnimalList> {
  TextEditingController _controller = TextEditingController();
  List<Animal> animals = [];

  @override
  void initState() {
    super.initState();
    _loadAnimals();
  }

  _loadAnimals() async {
    List<Animal> loadedAnimals = await DatabaseHelper.instance.getAllAnimals();
    setState(() {
      animals = loadedAnimals;
    });
  }

  _addAnimal() async {
    String name = _controller.text;
    if (name.isNotEmpty) {
      Animal newAnimal = Animal(name: name);
      await DatabaseHelper.instance.insertAnimal(newAnimal);
      _controller.clear();
      _loadAnimals();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter animal name',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _addAnimal,
                child: Text('Add'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: animals.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(animals[index].name),
              );
            },
          ),
        ),
      ],
    );
  }
}
