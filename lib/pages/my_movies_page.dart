import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_movies/pages/new_movie_page.dart';

import '../repository/firebase_api.dart';

class MyMoviesPage extends StatefulWidget {
  const MyMoviesPage({super.key});

  @override
  State<MyMoviesPage> createState() => _MyMoviesPageState();
}

class _MyMoviesPageState extends State<MyMoviesPage> {
  final FirebaseApi _firebaseApi = FirebaseApi();

  void _addButtonClicked() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewMoviePage()));
  }

  void _deleteMovie(QueryDocumentSnapshot movie) async {
    var result = await _firebaseApi.deleteMovie(movie);
    if (result == 'network-request-failed') {
      _showMessage('Revise su conexión a internet');
    }else {
      _showMessage('Pelicula eliminada con éxito');
    }
  }

  void _showMessage(String msg) {
    setState(() {
      SnackBar snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void _showAlertDialog(QueryDocumentSnapshot movie) {
    AlertDialog alert = AlertDialog(
      title: const Text('Advertencia'),
      content:
          Text("¿Está seguro que desea eliminar la película ${movie['name']}?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text('Cancelar')),
        TextButton(
            child: Text('Aceptar'),
            onPressed: () => {
                  _deleteMovie(movie),
                  Navigator.pop(context, 'OK'),
                }),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  InkWell _buildCard(QueryDocumentSnapshot movie) {
    return InkWell(
      onTap: () {
        print("clic");
      },
      onLongPress: () {
        print("longClic");
        _showAlertDialog(movie);
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(movie['name']),
              subtitle: Text(movie['actor']),
              leading: Image.network(
                movie['urlPicture'] ?? "",
              ),
            ),
        /*    Container(
              height: 100.0,
              width: 100.0,
              child: Ink.image(
                image: movie['urlPicture'] == ""
                    ? const AssetImage('assets/images/logo.png')
                        as ImageProvider
                    : NetworkImage(movie['urlPicture']),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),*/
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("movies").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("Loading");
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot movie = snapshot.data!.docs[index];
                    return _buildCard(movie);
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addButtonClicked,
        child: const Icon(Icons.add),
      ),
    );
  }
}
