import 'package:dartz/dartz.dart';
import '../../domain/entities/coin_balance.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/reward_repository.dart';
import '../../core/error/failures.dart';

class RewardRepositoryImpl implements RewardRepository {
  int _currentBalance = 1000;
  final List<Transaction> _transactions = [];

  @override
  Future<Either<Failure, CoinBalance>> getCurrentBalance() async {
    return Right(CoinBalance(coins: _currentBalance));
  }

  @override
  Future<Either<Failure, void>> updateBalance(int amount) async {
    _currentBalance += amount;
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionHistory() async {
    return Right(_transactions);
  }
}
