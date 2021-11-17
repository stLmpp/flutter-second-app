import 'package:flutter/material.dart';
import 'package:second_app/model/transaction.dart';
import 'package:second_app/utils/currency.dart';
import 'package:second_app/utils/date.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function({required Transaction transaction}) deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(child: Text('${currencyFormatter.format(transaction.amount)}')),
            )),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          dateFormatWithHours.format(transaction.date),
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () {
                  deleteTransaction(transaction: transaction);
                },
                icon: const Icon(Icons.delete),
                label: Text('Delete'),
              )
            : IconButton(
                onPressed: () {
                  deleteTransaction(transaction: transaction);
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
      ),
    );
  }
}
