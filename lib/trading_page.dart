

import 'package:flutter/material.dart';

import 'trading_bloc.dart';

void main() {
  runApp(const TradingPage());
}

class TradingPage extends StatefulWidget {
  const TradingPage({super.key});

  @override
  _TradingPageState createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage> {
  late TradingBloc _tradingBloc;

  @override
  void initState() {
    super.initState();
    _tradingBloc = TradingBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Trading Data'),
      ),
      body: StreamBuilder<List<dynamic>>(
        stream: _tradingBloc.tradesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data'));
          }

          final trades = snapshot.data!;
          return ListView.builder(
            itemCount: trades.length,
            itemBuilder: (context, index) {
              final trade = trades[index];
              return ListTile(
                title: Text('Symbol: ${trade['symbol']}'),
                subtitle: Text('Price: \$${trade['price']}'),
                trailing: Text('Quantity: ${trade['quantity']}'),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tradingBloc.dispose();
    super.dispose();
  }
}
