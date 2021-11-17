import 'package:flutter/material.dart';
import 'package:second_app/model/transaction.dart';
import 'package:second_app/widget/transaction_item.dart';

class TransactionsList extends StatelessWidget {
  TransactionsList({Key? key, required this.transactions, required this.deleteTransaction}) : super(key: key);

  final Function({required Transaction transaction}) deleteTransaction;

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) => Column(children: [
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
                height: constraints.maxHeight * 0.6,
              )
            ]),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return TransactionItem(transaction: transaction, deleteTransaction: deleteTransaction);
            },
          );
  }
}
