import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String id;
  final String name;
  final String type;
  final int duration;
  final double rating;
  final String description;
  final String imageUrl;
  final String trailer;
  final int year;

  Movie({
    required this.id,
    required this.name,
    required this.type,
    required this.duration,
    required this.rating,
    required this.description,
    required this.imageUrl,
    required this.trailer,
    required this.year,
  });

  // Firebase'den gelen veriyi Movie modeline dönüştürmek için bir factory metodu
  factory Movie.fromMap(Map<String, dynamic> data) {
    return Movie(
      id: data['id'],
      name: data['name'],
      type: data['type'],
      duration: data['duration'],
      rating: data['rating'].toDouble(),
      description: data['description'],
      imageUrl: data['image'],
      trailer: data['trailer'],
      year: data['year'],
    );
  }
}

class MovieAndSeriesProvider with ChangeNotifier {
  Movie? _selectedMovie; 

  Movie? get selectedMovie => _selectedMovie;

  void fetchMovie(String movieId) async {
    // Firebase'den belirli bir filmi çekme kodu
    FirebaseFirestore.instance
      .collection('movieandseries')
      .doc(movieId)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
          _selectedMovie = Movie.fromMap(data);  // _selectedMovie'yi günceller
          notifyListeners();
        } else {
          print('No movie found with this ID');
        }
      });
  }
}
