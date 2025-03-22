import 'package:dartz/dartz.dart';
import '../repositories/reward_repository.dart';
import '../entities/transaction.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import 'dart:math';

class ScratchCardUseCase extends UseCase<int, NoParams> {
  final RewardRepository repository;

  ScratchCardUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    int reward = Random().nextInt(451) + 50; // Between 50 and 500
    final updateResult = await repository.updateBalance(reward);

    return updateResult.fold(
      (failure) => Left(failure),
      (_) async {
        final transaction = Transaction(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: TransactionType.scratchReward,
          amount: reward,
          date: DateTime.now(),
        );
        await repository.addTransaction(transaction);
        return Right(reward);
      },
    );
  }
}

class NoParams {}
