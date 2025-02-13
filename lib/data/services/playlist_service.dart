import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlaylistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Lấy ID người dùng hiện tại
  String? get userId => _auth.currentUser?.uid;

  /// Tạo playlist mới
  Future<String?> createPlaylist(String playlistName) async {
    if (userId == null) return null;

    try {
      final playlistRef = await _firestore.collection("users").doc(userId).collection("playlists").add({
        "name": playlistName,
        "createdAt": Timestamp.now(),
      });

      return playlistRef.id; // Trả về ID của playlist mới tạo
    } catch (e) {
      print("Lỗi khi tạo playlist: $e");
      return null;
    }
  }

  /// Thêm bài hát vào playlist
  Future<void> addSongToPlaylist(
      String playlistId, String songId, String songName, String artistName, String imageUrl) async {
    if (userId == null) return;

    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("playlists")
          .doc(playlistId)
          .collection("songs")
          .doc(songId)
          .set({
        "songId": songId,
        "songName": songName,
        "artistName": artistName,
        "imageUrl": imageUrl,
        "addedAt": Timestamp.now(),
      });

      print("Đã thêm bài hát vào playlist!");
    } catch (e) {
      print("Lỗi khi thêm bài hát vào playlist: $e");
    }
  }

  /// Xóa bài hát khỏi playlist
  Future<void> removeSongFromPlaylist(String playlistId, String songId) async {
    if (userId == null) return;

    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("playlists")
          .doc(playlistId)
          .collection("songs")
          .doc(songId)
          .delete();

      print("Đã xóa bài hát khỏi playlist!");
    } catch (e) {
      print("Lỗi khi xóa bài hát khỏi playlist: $e");
    }
  }

  /// 🔄 Lấy danh sách playlist
  Stream<List<Map<String, dynamic>>> getPlaylists() {
    if (userId == null) return const Stream.empty();

    return _firestore.collection("users").doc(userId).collection("playlists").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          "playlistId": doc.id,
          "name": doc["name"],
        };
      }).toList();
    });
  }

  /// 🎵 Lấy danh sách bài hát trong playlist
  Stream<List<Map<String, dynamic>>> getSongsInPlaylist(String playlistId) {
    if (userId == null) return const Stream.empty();

    return _firestore
        .collection("users")
        .doc(userId)
        .collection("playlists")
        .doc(playlistId)
        .collection("songs")
        .snapshots()
        .map((snapshot) {
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

  /// Xóa playlist
  Future<void> deletePlaylist(String playlistId) async {
    if (userId == null) return;

    try {
      await _firestore.collection("users").doc(userId).collection("playlists").doc(playlistId).delete();
      print("Đã xóa playlist!");
    } catch (e) {
      print("Lỗi khi xóa playlist: $e");
    }
  }

  /// Kiểm tra bài hát có trong playlist chưa
  Future<bool> isSongInPlaylist(String playlistId, String songId) async {
    if (userId == null) return false;

    final songRef = _firestore
        .collection("users")
        .doc(userId)
        .collection("playlists")
        .doc(playlistId)
        .collection("songs")
        .doc(songId);

    final songDoc = await songRef.get();
    return songDoc.exists; // Trả về true nếu bài hát đã tồn tại
  }
}
