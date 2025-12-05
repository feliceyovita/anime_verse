import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/anime.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _usersCollection() {
    return _firestore.collection('users');
  }

  Stream<List<Anime>> getFavoriteStream(String userId) {
    return _usersCollection()
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Anime.fromFavoritesJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //add future
  Future<void> addFavorite(String userId, Anime anime) async {
    await _usersCollection()
        .doc(userId)
        .collection('favorites')
        .doc(anime.malId.toString())
        .set(anime.toJson());
  }

  Future<void> removeFavorite(String userID, int animeId) async {
    await _usersCollection()
        .doc(userID)
        .collection('favorites')
        .doc(animeId.toString())
        .delete();
  }

}