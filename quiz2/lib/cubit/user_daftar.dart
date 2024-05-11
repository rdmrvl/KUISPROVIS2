import 'dart:async'; // For Future
import 'package:http/http.dart' as http; // For making HTTP requests
  
  String url = "http://146.190.109.66:8000/users/";

  Future<int> insertData(String username, String password) async {   
  //data disimpan di body
  final response = await http.post(
         Uri.parse(url), 
         headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8'}, 
         body: """
              {"username": "${username}",
               "password": "${password}"} 
               """);
  	  return response.statusCode; //sukses kalau 201
  }

