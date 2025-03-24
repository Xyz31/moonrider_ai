import 'package:dartz/dartz.dart';
import 'package:moonrider_task/core/constants.dart';
import 'package:moonrider_task/core/utils/shared_prefernences.dart';
import 'package:moonrider_task/domain/entities/current_scratch_data.dart';
import '../../core/utils/notification_service.dart';
import '../../domain/entities/coin_balance.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/reward_repository.dart';
import '../../core/error/failures.dart';

class RewardRepositoryImpl implements RewardRepository {
  int _currentBalance = CurrentScratchDataEntity.instance.currentCoins;

  final List<Transaction> _transactions = [];

  @override
  Future<Either<Failure, CoinBalance>> getCurrentBalance() async {
    try {
      CurrentScratchDataEntity.instance.currentCoins = _currentBalance;
      return Right(CoinBalance(coins: _currentBalance));
    } catch (e) {
      return Left(LocalDeviceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateBalance(int amount) async {
    try {
      _currentBalance += amount;
      CurrentScratchDataEntity.instance.currentCoins = _currentBalance;
      return const Right(null);
    } catch (e) {
      return Left(LocalDeviceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addTransaction(Transaction transaction) async {
    try {
      _currentBalance += transaction.amount;
      print('#### RewardRepositoryImpl ::: currentBalance = $_currentBalance');
      CurrentScratchDataEntity.instance.currentCoins = _currentBalance;
      _transactions.add(transaction);
      await SharedPreferencesServices()
          .setInteger(AppConstants.LastCoinsPrefKey, _currentBalance);
      String title = transaction.type == TransactionType.redemption
          ? "Offer"
          : "Scratch Award";
      // send noti
      NotificationService()
          .showRedemptionNotification(title, transaction.amount);
      if (transaction.type == TransactionType.scratchReward) {
        SharedPreferencesServices().setLastDate(DateTime.now().toString());
      }
      return const Right(null);
    } catch (e) {
      return Left(LocalDeviceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionHistory() async {
    try {
      return Right(_transactions);
    } catch (e) {
      return Left(LocalDeviceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DateTime?>> getLastScratchDate() async {
    try {
      DateTime? prevDate = await SharedPreferencesServices().getLastDate();
      if (prevDate == null) return const Right(null);

      CurrentScratchDataEntity.instance.lastScratchTime = prevDate;

      //
      return Right(prevDate);
    } catch (e) {
      return Left(LocalDeviceFailure(e.toString()));
    }
  }
}
