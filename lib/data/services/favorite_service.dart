import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Lấy ID người dùng hiện tại
  String? get userId => _auth.currentUser?.uid;

  /// Thêm bài hát vào danh sách yêu thích
  Future<void> addFavoriteSong(String songId, String songName, String artistName, String imageUrl) async {
    if (userId == null) return;

    try {
      await _firestore.collection("users").doc(userId).collection("favorites").doc(songId).set({
        'songId': songId,
        "songName": songName,
        "artistName": artistName,
        "imageUrl": imageUrl,
        "addedAt": Timestamp.now(),
      });
      print("Đã thêm bài hát vào danh sách yêu thích!");
    } catch (e) {
      print("Lỗi khi thêm bài hát vào Firebase: $e");
    }
  }

  /// Xóa bài hát khỏi danh sách yêu thích
  Future<void> removeFavoriteSong(String songId) async {
    if (userId == null) return;

    try {
      await _firestore.collection("users").doc(userId).collection("favorites").doc(songId).delete();
      print("Đã xóa bài hát khỏi danh sách yêu thích!");
    } catch (e) {
      print("Lỗi khi xóa bài hát khỏi Firebase: $e");
    }
  }

  /// Lấy danh sách bài hát yêu thích từ Firebase
  Stream<List<Map<String, dynamic>>> getFavoriteSongs() {
    if (userId == null) {
      return const Stream.empty();
    }

    return _firestore.collection("users").doc(userId).collection("favorites").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          "songId": doc.id,
          "songName": doc["songName"],
          "artistName": doc["artistName"],
          "imageUrl": doc["imageUrl"],
        };
      }).toList();
    });
  }
}
