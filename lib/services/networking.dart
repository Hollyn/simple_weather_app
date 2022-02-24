import 'package:simple_weather_app/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper({required this.url});

  Future<dynamic> getData() async {
    try {
      Uri url = Uri.parse(this.url);
      http.Response result = await http.get(url);

      if (result.statusCode == 200) {
        var decodedJson = jsonDecode(result.body);
        return decodedJson;
      } else {
        throw result.statusCode.toString();
      }
    } catch (e) {
      rethrow;
    }
  }
}
