import 'dart:math';

import 'package:flutter/material.dart';
import 'package:second_app/model/transaction.dart';
import 'package:second_app/widget/chart.dart';
import 'package:second_app/widget/transaction_add.dart';
import 'package:second_app/widget/transactions_list.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.light().copyWith(secondary: Colors.amber),
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
            toolbarTextStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = List.generate(
    0,
    (index) => Transaction(
      title: 'Transaction $index',
      date: DateTime.now(),
      amount: double.parse((new Random().nextDouble() * new Random().nextInt(100)).toStringAsFixed(2)),
    ),
  ).toList();

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) => element.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
  }

  void _addTransaction({
    required String title,
    required num amount,
    required DateTime date,
  }) {
    Navigator.pop(context);
    setState(() {
      _transactions.add(Transaction(title: title, amount: amount, date: date));
    });
  }

  void _deleteTransaction({required Transaction transaction}) {
    setState(() {
      _transactions.removeWhere((element) => element.id == transaction.id);
    });
  }

  void _openTransactionAdd(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builderContext) => TransactionAdd(addTransaction: _addTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionAdd(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(recentTransactions: _recentTransactions),
            TransactionsList(transactions: _transactions, deleteTransaction: _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionAdd(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
