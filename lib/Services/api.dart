import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helper/helperfuncions.dart';

final url = dotenv.env['BACKEND_URL']!;

class Api {
  Future<String> getJwtToken() {
    return HelperFunctions.getUserJwtTokenInSharedPreference();
  }

  Future<http.Response> get(String path) async {
    String token = await getJwtToken();
    if (token != "Empty") {
      return await http.get(Uri.parse("$url$path"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      });
    } else {
      return await http.get(Uri.parse("$url$path"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
    }
  }

  Future<http.Response> post(String path, dynamic body) async {
    String token = await getJwtToken();
    if (token != "Empty") {
      return await http.post(Uri.parse("$url$path"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': '$token'
          },
          body: body);
    } else {
      return await http.post(Uri.parse("$url$path"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);
    }
  }
}
