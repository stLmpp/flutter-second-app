import 'package:flutter/material.dart';
import 'package:second_app/model/transaction.dart';
import 'package:second_app/utils/currency.dart';
import 'package:second_app/utils/date.dart';

class TransactionsList extends StatelessWidget {
  TransactionsList({Key? key, required this.transactions}) : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
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
                  ),
                );
                // return Card(
                //   key: ValueKey(transaction.id),
                //   child: Row(
                //     children: [
                //       Container(
                //         margin: const EdgeInsets.symmetric(
                //           horizontal: 16,
                //           vertical: 8,
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Theme.of(context).primaryColor,
                //             width: 2,
                //           ),
                //         ),
                //         padding: const EdgeInsets.all(8),
                //         child: Text(
                //           '${currencyFormatter.format(transaction.amount)}',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transaction.title,
                //             style: Theme.of(context).textTheme.headline6,
                //           ),
                //           Text(
                //             dateFormatWithHours.format(transaction.date),
                //             style: const TextStyle(color: Colors.grey),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
            ),
    );
  }
}
