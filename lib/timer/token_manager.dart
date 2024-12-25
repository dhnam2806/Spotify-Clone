import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify_clone/core/config/app_constant.dart';

class TokenManager {
  String token =
      'BQCxqAkxvZqUeZUxQme7UIAlf29tylpAzHrPSjYC8yjEoYvEkcUZW88VfAAl6CxZStkVxIZ-xIjeF_p8KDTMskmOgSw3OIeEtya6I1o5oA1AhPh_hB0';
  Timer? _timer;

  // Hàm để lấy access_token từ API
  Future<void> fetchAccessToken() async {
    const clientId = AppConstant.clientId;
    const clientSecret = AppConstant.clientSecret;

    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      body: {
        'grant_type': 'client_credentials',
        'client_id': clientId,
        'client_secret': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      token = data['access_token']; // Lưu access_token vào biến
      print('New token fetched: $token');
    } else {
      print('Failed to fetch token: ${response.statusCode} - ${response.body}');
    }
  }

  // Hàm khởi chạy định kỳ
  void startFetchingToken() {
    fetchAccessToken(); // Gọi ngay lần đầu tiên
    _timer = Timer.periodic(const Duration(minutes: 59), (_) => fetchAccessToken());
  }

  // Dừng việc gọi định kỳ
  void stopFetchingToken() {
    _timer?.cancel();
  }
}
