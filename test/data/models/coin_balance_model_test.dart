import 'package:flutter_test/flutter_test.dart';
import 'package:moonrider_task/data/models/coin_balance_model.dart';
import 'package:moonrider_task/domain/entities/coin_balance.dart';

void main() {
  const tCoinBalanceModel = CoinBalanceModel(coins: 500);

  test('CoinBalanceModel should be a subclass of CoinBalance entity', () {
    // Assert
    expect(tCoinBalanceModel, isA<CoinBalance>());
  });

  group('fromJson method', () {
    test('should return a valid model when JSON coins is an integer', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {'coins': 500};
      // Act
      final result = CoinBalanceModel.fromJson(jsonMap);
      // Assert
      expect(result, equals(tCoinBalanceModel));
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // Act
      final result = tCoinBalanceModel.toJson();
      // Assert
      final expectedMap = {'coins': 500};
      expect(result, expectedMap);
    });
  });
}
