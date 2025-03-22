import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:moonrider_task/domain/entities/coin_balance.dart';
import 'package:moonrider_task/domain/repositories/reward_repository.dart';
import 'package:moonrider_task/domain/usecases/get_balance.dart';

// Generate mocks
@GenerateMocks([RewardRepository])
import 'get_balance_test.mocks.dart';

void main() {
  late GetBalance usecase;
  late MockRewardRepository mockRewardRepository;

  setUp(() {
    mockRewardRepository = MockRewardRepository();
    usecase = GetBalance(mockRewardRepository);
  });

  const tCoinBalance = CoinBalance(coins: 1000);

  test('should get current balance from the repository', () async {
    // Arrange
    when(mockRewardRepository.getCurrentBalance())
        .thenAnswer((_) async => const Right(tCoinBalance));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, const Right(tCoinBalance));
    verify(mockRewardRepository.getCurrentBalance());
    verifyNoMoreInteractions(mockRewardRepository);
  });
}
