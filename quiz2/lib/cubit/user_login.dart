import 'dart:async'; // For Future
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // For making HTTP requests

  // String url = "http://146.190.109.66:8000/login";

  // Future<int> loginData(String username, String password) async {   
  // //data disimpan di body
  // final response = await http.post(
  //        Uri.parse(url), 
  //        headers: <String, String>{
  //        'Content-Type': 'application/json; charset=UTF-8'}, 
  //        body: """
  //             {"username": "${username}",
  //              "password": "${password}"} 
  //              """);
  // 	  return response.statusCode; //sukses kalau 201
  // }

  Future<int> login(String username, String password) async {
  final url = Uri.parse('http://146.190.109.66:8000/login');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'username': username, 'password': password});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final userId = responseData['user_id'].toString();
    final token = responseData['access_token'].toString();

    // Simpan token dan user ID di SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    await prefs.setString('token', token);

    return response.statusCode;
  }else{
    throw Exception('Login failed');
  }
  
}
