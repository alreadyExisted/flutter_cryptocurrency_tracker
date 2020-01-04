import 'package:flutter_cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:flutter_cryptocurrency_tracker/services/api/call_api.dart';

Future<List<Cryptocurrency>> fetchCryptocurrencies() async {
  List<dynamic> data =
      await callApi('/v1/cryptocurrency/listings/latest?limit=10');
  return data.map((json) => Cryptocurrency.fromJson(json)).toList();
}
