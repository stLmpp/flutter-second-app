int uid = 0;

class Transaction {
  Transaction({
    required this.title,
    required this.amount,
    required this.date,
  });

  final int id = uid++;
  final String title;
  final num amount;
  final DateTime date;
}
