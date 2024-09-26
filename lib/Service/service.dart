import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> getRequestWithoutModel() async {
    try {
      Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/users");
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        final mode = jsonDecode(response.body);
        return mode;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
