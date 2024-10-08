import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre { male, female }

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();
  final _city = TextEditingController();

  bool _isPasswordObscure = true;
  bool _isRepPasswordObscure = true;

  Genre? _genre = Genre.male;
  bool _isActionFavorite = false;
  bool _isAdventureFavorite = false;
  bool _isComicFavorite = false;
  bool _isFantasyFavorite = false;
  bool _isLoveFavorite = false;
  bool _isTerrorFavorite = false;

  String buttonMsg = "Fecha de Nacimiento";

  DateTime _data = DateTime.now();

  final List<String> _cities = [
    'Barranquilla',
    'Bogotá',
    'Cali',
    'Medellin',
    'Pereira'
  ];

  String _dateConverter(DateTime newDate) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateFormatted = formatter.format(newDate);
    return dateFormatted;
  }

  void _showSelectedDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      locale: const Locale("es", "CO"),
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
      helpText: "Fecha de Nacimiento",
    );
    if (newDate != null) {
      setState(() {
        _data = newDate;
        buttonMsg = "Fecha de nacimiento ${_dateConverter(_data)}";
      });
    }
  }

  void _showMessage(String msg) {
    setState(() {
      SnackBar snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void _registerUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void _onRegisterButtonClicked() {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      _showMessage("ERROR: Debe digitar correo electrónico y contraseña");
    } else if (_password.text != _repPassword.text) {
      _showMessage("ERROR: Las contraseñas deben de ser iguales");
    } else {
      String genre = _genre == Genre.male ? "Masculino" : "Femenino";
      var user = User(
          _name.text,
          _email.text,
          _password.text,
          genre,
          _isActionFavorite,
          _isAdventureFavorite,
          _isComicFavorite,
          _isFantasyFavorite,
          _isLoveFavorite,
          _isTerrorFavorite,
          _data.toString(),
          _city.text);
      _registerUser(user);

      /* code */
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Digite su nombre",
                      prefixIcon: Icon(Icons.person)),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Digite su correo electrónico",
                        helperText: "*Campo obligatorio",
                        prefixIcon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        value!.isValidEmail() ? null : "Correo inválido"),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _password,
                    obscureText: _isPasswordObscure,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Digite su contraseña",
                      helperText: "*Campo obligatorio",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(_isPasswordObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isPasswordObscure = !_isPasswordObscure;
                            });
                          }),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value!.isPasswordValid()
                        ? null
                        : "La contraseña debe tener mínimo 6 caracteres"),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _repPassword,
                  obscureText: _isRepPasswordObscure,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Repita la contraseña",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(_isRepPasswordObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isRepPasswordObscure = !_isRepPasswordObscure;
                          });
                        }),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                DropdownMenu<String>(
                  width: 380,
                  enableFilter: true,
                  requestFocusOnTap: true,
                  label: const Text('Ciudad de residencia'),
                  onSelected: (String? city) {
                    setState(() {
                      _city.text = city!;
                    });
                  },
                  dropdownMenuEntries:
                      _cities.map<DropdownMenuEntry<String>>((String city) {
                    return DropdownMenuEntry<String>(value: city, label: city);
                  }).toList(),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text("Seleccione su género"),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text("Masculino"),
                        leading: Radio<Genre>(
                          value: Genre.male,
                          groupValue: _genre,
                          onChanged: (Genre? value) {
                            setState(() {
                              _genre = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text("Femenino",
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                        leading: Radio<Genre>(
                          value: Genre.female,
                          groupValue: _genre,
                          onChanged: (Genre? value) {
                            setState(() {
                              _genre = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Text("Genero de la película"),
                CheckboxListTile(
                    title: const Text("Acción"),
                    value: _isActionFavorite,
                    selected: _isActionFavorite,
                    onChanged: (bool? value) {
                      setState(() {
                        _isActionFavorite = value!;
                      });
                    }),
                CheckboxListTile(
                    title: const Text("Amor"),
                    value: _isLoveFavorite,
                    selected: _isLoveFavorite,
                    onChanged: (bool? value) {
                      setState(() {
                        _isLoveFavorite = value!;
                      });
                    }),
                CheckboxListTile(
                    title: const Text("Aventura"),
                    value: _isAdventureFavorite,
                    selected: _isAdventureFavorite,
                    onChanged: (bool? value) {
                      setState(() {
                        _isAdventureFavorite = value!;
                      });
                    }),
                CheckboxListTile(
                    title: const Text("Fantasia"),
                    value: _isFantasyFavorite,
                    selected: _isFantasyFavorite,
                    onChanged: (bool? value) {
                      setState(() {
                        _isFantasyFavorite = value!;
                      });
                    }),
                CheckboxListTile(
                    title: const Text("Humor"),
                    value: _isComicFavorite,
                    selected: _isComicFavorite,
                    onChanged: (bool? value) {
                      setState(() {
                        _isComicFavorite = value!;
                      });
                    }),
                CheckboxListTile(
                    title: const Text("Terror"),
                    value: _isTerrorFavorite,
                    selected: _isTerrorFavorite,
                    onChanged: (bool? value) {
                      setState(() {
                        _isTerrorFavorite = value!;
                      });
                    }),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                    child: Text(buttonMsg),
                    onPressed: () {
                      _showSelectedDate();
                    }),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      _onRegisterButtonClicked();
                    },
                    child: const Text("Registrar")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension on String {
  bool isPasswordValid() {
    return this.length > 5;
  }
}
