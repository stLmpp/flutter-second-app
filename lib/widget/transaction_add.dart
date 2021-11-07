import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:second_app/utils/currency.dart';

class TransactionAdd extends StatefulWidget {
  TransactionAdd({Key? key, required this.addTransaction}) : super(key: key);

  final Function({required String title, required num amount}) addTransaction;

  @override
  _TransactionAddState createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void _addTransaction() {
    final String title = _titleController.text;
    final String amountString = _amountController.text;
    if (title.isEmpty || amountString.isEmpty) {
      return;
    }
    final num amount = currencyFormatter.parse(amountString);
    if (amount < 0) {
      return;
    }
    widget.addTransaction(title: title, amount: amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [CurrencyTextInputFormatter(locale: 'pt-BR', decimalDigits: 2, symbol: 'R\$')],
              controller: _amountController,
              onSubmitted: (_) => _addTransaction(),
            ),
            TextButton(
              onPressed: _addTransaction,
              child: Text('Add transaction'),
            )
          ],
        ),
      ),
    );
  }
}
