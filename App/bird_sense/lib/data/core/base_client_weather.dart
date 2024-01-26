
import 'package:http/http.dart' as http;

abstract class WABaseClient {
  Future<dynamic> get(Uri uri) async {
    return http.get(uri);
  }
}