import 'package:http/http.dart' as http;

abstract class BSBaseClient {
  Future<dynamic> get(Uri uri) async {
    return http.get(uri);
  }
}