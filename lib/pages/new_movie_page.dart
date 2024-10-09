import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../models/movie.dart';
import '../repository/firebase_api.dart';

class NewMoviePage extends StatefulWidget {
  const NewMoviePage({super.key});

  @override
  State<NewMoviePage> createState() => _NewMoviePageState();
}

class _NewMoviePageState extends State<NewMoviePage> {
  final FirebaseApi _firebaseApi = FirebaseApi();

  final _name = TextEditingController();
  final _actor = TextEditingController();
  final _duration = TextEditingController();

  double _rating = 3.0;

  bool _isActionGenre = false, _isAdventureGenre = false, _isDramaGenre = false;
  bool _isFantasyGenre = false,
      _isFictionGenre = false,
      _isRomanceGenre = false;
  bool _isSuspenseGenre = false, _isTerrorGenre = false;

  Future<void> _saveMovieButtonClicked() async {

    var movie = Movie(
        "",
         _name.text,
        _actor.text,
        int.parse(_duration.text),
         _rating,
        _isActionGenre,
        _isAdventureGenre,
        _isDramaGenre,
        _isFantasyGenre,
         _isFictionGenre,
        _isRomanceGenre,
        _isSuspenseGenre,
        _isTerrorGenre,
        "");

    var result = await _firebaseApi.createMovie(movie, image);

    if (result == 'network-request-failed') {
      showMessage('Revise su conexión a internet');
    } else {
      showMessage('Película creada exitosamente');
      Navigator.pop(context);
    }
  }

  void showMessage(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Película'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 170,
                child: Stack(
                  children: [
                    image != null
                        ? Image.file(image!, width: 150, height: 150)
                        : const Image(
                            image: AssetImage('assets/images/logo.png'),
                            width: 150,
                            height: 150,
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        alignment: Alignment.bottomLeft,
                        onPressed: () async {
                          pickImage();
                        },
                        icon: const Icon(Icons.camera_alt),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nombre'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _actor,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Actor(es)'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _duration,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Duración'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 16.0,
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Género(s) de la Película',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Acción'),
                      value: _isActionGenre,
                      selected: _isActionGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isActionGenre = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Aventura'),
                      value: _isAdventureGenre,
                      selected: _isAdventureGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isAdventureGenre = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Drama'),
                      value: _isDramaGenre,
                      selected: _isDramaGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isDramaGenre = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Fantasia'),
                      value: _isFantasyGenre,
                      selected: _isFantasyGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFantasyGenre = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Ficción'),
                      value: _isFictionGenre,
                      selected: _isFictionGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFictionGenre = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Romance'),
                      value: _isRomanceGenre,
                      selected: _isRomanceGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isRomanceGenre = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Suspenso'),
                      value: _isSuspenseGenre,
                      selected: _isSuspenseGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isSuspenseGenre = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Terror'),
                      value: _isTerrorGenre,
                      selected: _isTerrorGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isTerrorGenre = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _saveMovieButtonClicked();
                },
                child: const Text('Guardar película'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
