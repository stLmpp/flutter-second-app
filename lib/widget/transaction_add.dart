import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:second_app/utils/currency.dart';
import 'package:second_app/utils/date.dart';

class TransactionAdd extends StatefulWidget {
  TransactionAdd({Key? key, required this.addTransaction}) : super(key: key);

  final Function({required String title, required num amount, required DateTime date}) addTransaction;

  @override
  _TransactionAddState createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  DateTime _date = DateTime.now();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController(text: dateFormat.format(DateTime.now()));

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
    widget.addTransaction(title: title, amount: amount, date: _date);
  }

  Future<void> _showDatePicker() async {
    final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now());
    if (date == null) {
      return;
    }
    _date = date;
    _dateController.text = dateFormat.format(_date);
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
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [CurrencyTextInputFormatter(locale: 'pt-BR', decimalDigits: 2, symbol: 'R\$')],
              controller: _amountController,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _showDatePicker,
                  )),
              readOnly: true,
              controller: _dateController,
            ),
            TextButton(
              onPressed: _addTransaction,
              child: const Text('Add transaction'),
            )
          ],
        ),
      ),
    );
  }
}
