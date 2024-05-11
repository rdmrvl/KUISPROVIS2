import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> getAccessToken(String username, String password) async {
  final tokenUrl = Uri.parse('http://146.190.109.66:8000/token');
  final response = await http.post(
    tokenUrl,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      'grant_type': '',
      'username': username,
      'password': password,
      'scope': '',
      'client_id': '',
      'client_secret': '',
    },
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData['access_token'];
  } else {
    print('Failed to obtain access token: ${response.statusCode}');
    return null;
  }
}

Future<Map<String, dynamic>?> makeAuthenticatedRequest(
    String endpoint, String accessToken) async {
  final response = await http.get(
    Uri.parse(endpoint),
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('Failed to make authenticated request: ${response.statusCode}');
    return null;
  }
}