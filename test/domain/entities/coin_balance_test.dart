import 'package:flutter_test/flutter_test.dart';
import 'package:moonrider_task/domain/entities/coin_balance.dart';

void main() {
  test('CoinBalance should contain required properties', () {
    // Arrange & Act
    const coinBalance = CoinBalance(coins: 100);

    // Assert
    expect(coinBalance.coins, 100);
  });

  test('CoinBalance instances with same values should be equal', () {
    // Arrange
    const coinBalance1 = CoinBalance(coins: 200);
    const coinBalance2 = CoinBalance(coins: 200);

    // Assert
    expect(coinBalance1.coins, coinBalance2.coins);
  });
}
