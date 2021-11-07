import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_app/model/grouped-transaction.dart';
import 'package:second_app/model/transaction.dart';
import 'package:second_app/widget/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<GroupedTransaction> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDate = DateTime.now().subtract(Duration(days: index));
      final weekDay = DateFormat.E().format(weekDate).substring(0, 1);

      final double amount = recentTransactions
          .where((transaction) =>
              transaction.date.day == weekDate.day && transaction.date.month == weekDate.month && transaction.date.year == weekDate.year)
          .fold(0, (acc, transaction) => acc + transaction.amount);

      return GroupedTransaction(day: weekDay, amount: amount);
    }).reversed.toList();
  }

  double get _maxSpending {
    return _groupedTransactionValues.fold(0, (acc, transaction) => acc + transaction.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactionValues
              .map((transaction) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: transaction.day,
                      amount: transaction.amount,
                      percent: _maxSpending == 0 ? 0 : transaction.amount / _maxSpending,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
