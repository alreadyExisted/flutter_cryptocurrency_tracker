import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiHost = 'https://pro-api.coinmarketcap.com';
const String apiKey = 'e38dc58d-bbe8-49c0-8140-5cc254bcbffd';

Future<dynamic> callApi(String url) async {
  final response =
      await http.get(apiHost + url, headers: {'X-CMC_PRO_API_KEY': apiKey});

  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  } else {
    throw Exception('Failed to load record');
  }
}
