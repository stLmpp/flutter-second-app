import 'package:flutter/material.dart';
import 'package:second_app/model/transaction.dart';
import 'package:second_app/utils/currency.dart';
import 'package:second_app/utils/date.dart';

class TransactionsList extends StatelessWidget {
  TransactionsList({Key? key, required this.transactions, required this.deleteTransaction}) : super(key: key);

  final Function({required Transaction transaction}) deleteTransaction;

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(children: [
            Text(
              'No transactions added yet!',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 32),
            Container(
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
              height: 200,
            )
          ])
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
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
                  trailing: IconButton(
                    onPressed: () {
                      deleteTransaction(transaction: transaction);
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ),
              );
            },
          );
  }
}
