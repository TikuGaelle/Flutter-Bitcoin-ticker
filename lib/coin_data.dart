import "package:http/http.dart" as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  static const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
  static const apiKey = 'NDQwNjIzZDNkMTQ4NGQ5YmJkZGFmZjc2NDY0NmU1ODk';

  Future getCoinData(String currency) async {

    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      http.Response response = await http.get(
          Uri.parse('$coinAPIURL/$crypto/$currency?apikey=$apiKey'));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
        //print(lastPrice);

      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
      return cryptoPrices;
    }
  }

}