import 'package:http/http.dart' as http;

class ApiHandler {
  Future<http.Response> makeGetRequest() {
    return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }
}
