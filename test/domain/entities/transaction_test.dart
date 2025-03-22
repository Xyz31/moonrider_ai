import 'package:flutter_test/flutter_test.dart';
import 'package:moonrider_task/domain/entities/transaction.dart';

void main() {
  test('Transaction should contain required properties', () {
    // Arrange
    final date = DateTime(2025, 3, 21);
    final transaction = Transaction(
      id: '12345',
      type: TransactionType.scratchReward,
      amount: 100,
      date: date,
    );

    // Assert
    expect(transaction.id, '12345');
    expect(transaction.type, TransactionType.scratchReward);
    expect(transaction.amount, 100);
    expect(transaction.date, date);
  });

  test('TransactionType enum should have correct values', () {
    // Assert
    expect(TransactionType.values.length, 2);
    expect(TransactionType.scratchReward.index, 0);
    expect(TransactionType.redemption.index, 1);
  });
}
