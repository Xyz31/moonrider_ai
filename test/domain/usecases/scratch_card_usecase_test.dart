import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:moonrider_task/core/error/failures.dart';
import 'package:moonrider_task/core/usecase/usecase.dart';
import 'package:moonrider_task/domain/entities/transaction.dart';
import 'package:moonrider_task/domain/repositories/reward_repository.dart'; // Add this import
import 'package:moonrider_task/domain/usecases/scratch_card_usecase.dart';

import 'get_balance_test.mocks.dart';

// Generate mocks before trying to import the generated file
@GenerateMocks([RewardRepository])
void main() {
  late ScratchCardUseCase usecase;
  late MockRewardRepository mockRewardRepository;

  setUp(() {
    mockRewardRepository = MockRewardRepository();
    usecase = ScratchCardUseCase(mockRewardRepository);
  });

  group('ScratchCardUseCase', () {
    test('should return a reward between 50 and 500', () async {
      // Arrange
      when(mockRewardRepository.updateBalance(any))
          .thenAnswer((_) async => const Right(null));
      when(mockRewardRepository.addTransaction(any))
          .thenAnswer((_) async => const Right(null));

      // Act - Create an instance of NoParams
      final result = await usecase(NoParams());

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Test should not reach here'),
        (reward) {
          expect(reward, greaterThanOrEqualTo(50));
          expect(reward, lessThanOrEqualTo(500));
        },
      );

      // Verify interactions
      verify(mockRewardRepository.updateBalance(any));
      verify(mockRewardRepository.addTransaction(any));
      verifyNoMoreInteractions(mockRewardRepository);
    });

    test('should add transaction with correct type and amount', () async {
      // Arrange
      when(mockRewardRepository.updateBalance(any))
          .thenAnswer((_) async => const Right(null));
      when(mockRewardRepository.addTransaction(any))
          .thenAnswer((_) async => const Right(null));

      // Act - Create an instance of NoParams
      final result = await usecase(NoParams());

      // Assert
      expect(result.isRight(), true);

      // Capture the transaction
      final capturedTransaction =
          verify(mockRewardRepository.addTransaction(captureAny)).captured.first
              as Transaction;
      expect(capturedTransaction.type, equals(TransactionType.scratchReward));
      expect(capturedTransaction.amount, greaterThanOrEqualTo(50));
      expect(capturedTransaction.amount, lessThanOrEqualTo(500));
      expect(capturedTransaction.id, isNotEmpty);
      expect(capturedTransaction.date, isNotNull);
    });

    test('should return failure when updateBalance fails', () async {
      // Arrange
      const failure = ServerFailure('Failed to update balance');
      when(mockRewardRepository.updateBalance(any))
          .thenAnswer((_) async => const Left(failure));

      // Act - Create an instance of NoParams
      final result = await usecase(NoParams());

      // Assert
      expect(result, equals(const Left(failure)));
      verify(mockRewardRepository.updateBalance(any));
      verifyNoMoreInteractions(mockRewardRepository);
    });
  });
}
