enum TransactionType { scratchReward, redemption }

class Transaction {
  final String id;
  final TransactionType type;
  final int amount;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
  });
}
