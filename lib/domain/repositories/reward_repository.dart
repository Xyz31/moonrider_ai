import 'package:dartz/dartz.dart';
import '../entities/coin_balance.dart';
import '../entities/transaction.dart';
import '../../core/error/failures.dart';

abstract class RewardRepository {
  Future<Either<Failure, CoinBalance>> getCurrentBalance();
  Future<Either<Failure, void>> updateBalance(int amount);
  Future<Either<Failure, void>> addTransaction(Transaction transaction);
  Future<Either<Failure, List<Transaction>>> getTransactionHistory();
}
