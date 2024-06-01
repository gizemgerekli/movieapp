import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:movie_app/providers/movieandseries_provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'), // Sayfa başlığı
        actions: [
          IconButton(
            icon: Icon(Icons.search), // Arama simgesi
            onPressed: () {
              showSearch(context: context, delegate: MovieSearchDelegate());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Search for movies and series!'),
      ),
    );
  }
}

class MovieSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Arama sorgusunu temizle
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query); // Arama ekranını kapat
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Arama sonuçlarını burada göster
    final movieProvider = Provider.of<MovieAndSeriesProvider>(context, listen: false);
    movieProvider.fetchMovie(query); // Arama sorgusuna göre film/dizi verisini getir

    return Center(
      child: CircularProgressIndicator(), // Yükleniyor göstergesi
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Arama önerilerini burada göster (isteğe bağlı)
    return Container(); // Öneri yoksa boş bir widget döndür
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieAndSeriesProvider(), // Provider'ı başlat
      child: MaterialApp(
        home: SearchScreen(),
      ),
    ),
  );
}
