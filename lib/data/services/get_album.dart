import 'package:http/http.dart' as http;
import 'package:spotify_clone/data/dtos/release_dto.dart';
import 'package:spotify_clone/timer/token_manager.dart';

class NewRealeaseService {
  static const String _baseUrl = 'https://api.spotify.com/v1/browse/new-releases';
  Future<RealeaseDto?> getAlbums() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer BQCSsPVmOHBkoLQqZanTEWQV_mppzdOALiDpmNVGFDm-Q7PzhuK7RNFEiOVbtYg_oO2bj2yk5KbgJBRB4fjVRzweOFWr2l68hsai1v_W0P6oI9fcryI',
          'Content-Type': 'application/json',
        },
      );
      return RealeaseDto.fromJson(response.body);
    } catch (e) {
      print(e);
    }
  }
}
