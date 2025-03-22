import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moonrider_task/data/repositories/reward_repository_impl.dart';
import 'package:moonrider_task/domain/entities/coin_balance.dart';
import 'package:moonrider_task/domain/entities/transaction.dart';

void main() {
  late RewardRepositoryImpl repository;

  setUp(() {
    repository = RewardRepositoryImpl();
  });

  group('getCurrentBalance', () {
    test('should return current balance', () async {
      // Act
      final result = await repository.getCurrentBalance();

      // Assert
      expect(result, isA<Right<dynamic, CoinBalance>>());
      result.fold(
        (failure) => fail('Test should not reach here'),
        (balance) => expect(balance.coins, 1000), // Initial balance value
      );
    });
  });

  group('updateBalance', () {
    test('should update balance correctly when adding coins', () async {
      // Act
      await repository.updateBalance(500);
      final result = await repository.getCurrentBalance();

      // Assert
      result.fold(
        (failure) => fail('Test should not reach here'),
        (balance) => expect(balance.coins, 1500),
      );
    });

    test('should update balance correctly when removing coins', () async {
      // Act
      await repository.updateBalance(-300);
      final result = await repository.getCurrentBalance();

      // Assert
      result.fold(
        (failure) => fail('Test should not reach here'),
        (balance) => expect(balance.coins, 700),
      );
    });
  });

  group('addTransaction and getTransactionHistory', () {
    test('should add transaction and retrieve it in history', () async {
      // Arrange
      final transaction = Transaction(
        id: '123',
        type: TransactionType.scratchReward,
        amount: 200,
        date: DateTime.now(),
      );

      // Act - Add transaction
      final addResult = await repository.addTransaction(transaction);

      // Assert - Add result
      expect(addResult, isA<Right<dynamic, void>>());

      // Act - Get history
      final historyResult = await repository.getTransactionHistory();

      // Assert - History result
      historyResult.fold(
        (failure) => fail('Test should not reach here'),
        (transactions) {
          expect(transactions.length, 1);
          expect(transactions[0].id, transaction.id);
          expect(transactions[0].type, transaction.type);
          expect(transactions[0].amount, transaction.amount);
        },
      );
    });

    test('should maintain transaction order in history', () async {
      // Arrange
      final transaction1 = Transaction(
        id: '123',
        type: TransactionType.scratchReward,
        amount: 200,
        date: DateTime.now(),
      );
      final transaction2 = Transaction(
        id: '456',
        type: TransactionType.redemption,
        amount: -100,
        date: DateTime.now(),
      );

      // Act
      await repository.addTransaction(transaction1);
      await repository.addTransaction(transaction2);
      final historyResult = await repository.getTransactionHistory();

      // Assert
      historyResult.fold(
        (failure) => fail('Test should not reach here'),
        (transactions) {
          expect(transactions.length, 2);
          expect(transactions[0].id, transaction1.id);
          expect(transactions[1].id, transaction2.id);
        },
      );
    });
  });
}
