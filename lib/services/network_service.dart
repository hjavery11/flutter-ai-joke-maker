import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<String> fetchJoke(String topic) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    if (response.statusCode == 200) {
      // Assuming the response body contains a field 'joke' with the joke text
     // final data = jsonDecode(response.body);
      //return data['joke'];
      print('$topic');
      return topic;

    } else {
      throw Exception('Failed to load joke');
    }
  }
}