import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/anime.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //colection references
  CollectionReference _userCollection(){
    return _firestore.collection('users');
  }

  // Get favorites stream
  Stream<List<Anime>> getFavoritesStream(String userId) {
    return _userCollection()
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Anime.fromFavoritesJson(doc.data());
      }).toList();
    });
  }

  // Add favorite
  Future<void> addFavorite(String userId, Anime anime) async {
    await _userCollection()
        .doc(userId)
        .collection('favorites')
        .doc(anime.malId.toString())
        .set(anime.toJson());
  }

  //Remove favorite
  Future<void> removeFavorite(String userId, Anime anime) async {
    await _userCollection()
        .doc(userId)
        .collection('favorites')
        .doc(anime.malId.toString())
        .set(anime.toJson());
  }
}
