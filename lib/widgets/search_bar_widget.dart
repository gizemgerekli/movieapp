import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _filter = new TextEditingController();
  Future<QuerySnapshot>? _future; 

  _SearchBarWidgetState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _future = null;
        });
      } else {
        setState(() {
          _future = FirebaseFirestore.instance
              .collection('movies')
              .where('title', isGreaterThanOrEqualTo: _filter.text)
              .get();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _filter,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Ara...',
            ),
          ),
        ),
        Expanded(
          child: _future == null
              ? Container()
              : FutureBuilder<QuerySnapshot>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Hata: ${snapshot.error}'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data?.docs?.length ?? 0,
                        itemBuilder: (context, index) {
                          DocumentSnapshot? movie = snapshot.data?.docs?[index];
                          return ListTile(
                            title: Text(movie?['title'] ?? ''),
                            subtitle: Text(movie?['description'] ?? ''),
                          );
                        },
                      );
                    }
                  },
                ),
        ),
      ],
    );
  }
}
