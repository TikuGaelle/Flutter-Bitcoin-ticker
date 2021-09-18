import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'AUD';
  //String currency = '';

//function which returns a list of drop down menu items i\using the cupertino design.
  List<Widget> getPickerItems() {

    List<Widget> ItemsList = [];

    for (String currency in currenciesList){
      //selectedCurrency = currency;
      var newItems = Text(currency);
      ItemsList.add(newItems);
    }
    return ItemsList;
  }

  //String bitcoinValueInUSD = '?';
Map<String, String> coinValues = {};

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

    @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        CryptoCard(
          cryptoCurrency: 'BTC',
          value: isWaiting ? '?' : coinValues['BTC'],
          selectedCurrency: selectedCurrency,
        ),
          CryptoCard(
            cryptoCurrency: 'ETH',
            value: isWaiting ? '?' : coinValues['ETH'],
            selectedCurrency: selectedCurrency,
          ),
          CryptoCard(
            cryptoCurrency: 'LTC',
            value: isWaiting ? '?' : coinValues['LTC'],
            selectedCurrency: selectedCurrency,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 50.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              backgroundColor: Colors.lightBlue,
              itemExtent: 38.0,
            onSelectedItemChanged: (selectedIndex){
                setState(() {
                  selectedCurrency = currenciesList[selectedIndex];
                  getData();
//                  print(selectedCurrency);
//                  print(selectedIndex);
                });
            },
            children:getPickerItems(),
            )
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  //2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}