import 'package:dartz/dartz.dart';
import 'package:moonrider_task/core/constants.dart';
import 'package:moonrider_task/core/utils/shared_prefernences.dart';
import 'package:moonrider_task/domain/entities/current_scratch_data.dart';
import '../repositories/reward_repository.dart';
import '../entities/transaction.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import 'dart:math';

class ScratchCardUseCase extends UseCase<int, NoParams> {
  final RewardRepository repository;

  ScratchCardUseCase(this.repository);
// /*
  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    int reward = Random().nextInt(451) + 50; // Between 50 and 500
    final transaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: TransactionType.scratchReward,
      amount: reward,
      date: DateTime.now(),
    );
    final updateResult = await repository.addTransaction(transaction);
    CurrentScratchDataEntity.instance.rewardCoins = reward;
    await SharedPreferencesServices()
        .setInteger(AppConstants.LastEarnedCoinsPrefKey, reward);

    CurrentScratchDataEntity.instance.lastScratchTime = DateTime.now();
    CurrentScratchDataEntity.instance.nextScratchTime =
        DateTime.now().copyWith(hour: DateTime.now().hour + 1);
    return updateResult.fold(
      (failure) => Left(failure),
      (_) async {
        print('### ScratchCardUseCase :: Reward got : $reward ##');
        return Right(reward);
      },
    );
  }
  // */
}
