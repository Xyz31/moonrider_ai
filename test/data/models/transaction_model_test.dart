import 'package:flutter_test/flutter_test.dart';
import 'package:moonrider_task/data/models/transaction_model.dart';
import 'package:moonrider_task/domain/entities/transaction.dart';

void main() {
  final testDate = DateTime(2025, 3, 21);
  final tTransactionModel = TransactionModel(
    id: 'test123',
    type: TransactionType.scratchReward,
    amount: 150,
    date: testDate,
  );

  test('TransactionModel should be a subclass of Transaction entity', () {
    // Assert
    expect(tTransactionModel, isA<Transaction>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'id': 'test123',
        'type': 0, // TransactionType.scratchReward
        'amount': 150,
        'date': '2025-03-21T00:00:00.000',
      };
      // Act
      final result = TransactionModel.fromJson(jsonMap);
      // Assert
      expect(result, tTransactionModel);
    });

    test('should handle different TransactionType values', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'id': 'test123',
        'type': 1, // TransactionType.redemption
        'amount': 150,
        'date': '2025-03-21T00:00:00.000',
      };
      final expectedModel = TransactionModel(
        id: 'test123',
        type: TransactionType.redemption,
        amount: 150,
        date: testDate,
      );
      // Act
      final result = TransactionModel.fromJson(jsonMap);
      // Assert
      expect(result.type, TransactionType.redemption);
      expect(result, expectedModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // Act
      final result = tTransactionModel.toJson();
      // Assert
      final expectedMap = {
        'id': 'test123',
        'type': 0,
        'amount': 150,
        'date': '2025-03-21T00:00:00.000',
      };
      expect(result, expectedMap);
    });
  });
}
