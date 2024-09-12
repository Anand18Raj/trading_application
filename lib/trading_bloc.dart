import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class TradingBloc {
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8080'), 
  );

  final _tradesController = StreamController<List<dynamic>>();
  Stream<List<dynamic>> get tradesStream => _tradesController.stream;

  double? _highestPrice;
  double? _lowestPrice;

  TradingBloc() {
    _channel.stream.listen((data) {
      final trades = jsonDecode(data as String) as List<dynamic>;
      _processTrades(trades);
      _tradesController.sink.add(trades);
    });
  }

  void _processTrades(List<dynamic> trades) {
    for (var trade in trades) {
      final price = double.parse(trade['price']);

      // Update highest and lowest prices
      if (_highestPrice == null || price > _highestPrice!) {
        _highestPrice = price;
      }
      if (_lowestPrice == null || price < _lowestPrice!) {
        _lowestPrice = price;
      }

      // Determine if we need to place a buy or sell order
      if (_highestPrice != null && price <= _highestPrice! * 0.95) {
        _placeBuyOrder(price);
        _highestPrice = null; // Reset highest price after buy
      }
      if (_lowestPrice != null && price >= _lowestPrice! * 1.05) {
        _placeSellOrder(price);
        _lowestPrice = null; // Reset lowest price after sell
      }
    }
  }

  void _placeBuyOrder(double price) {
    print('Placing buy order at price: \$${price}');
  }

  void _placeSellOrder(double price) {
    print('Placing sell order at price: \$${price}');
  }

  void dispose() {
    _channel.sink.close();
    _tradesController.close();
  }
}
