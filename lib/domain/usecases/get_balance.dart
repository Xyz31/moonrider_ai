import 'package:dartz/dartz.dart';
import '../repositories/reward_repository.dart';
import '../entities/coin_balance.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';

class GetBalance extends UseCase<CoinBalance, NoParams> {
  final RewardRepository repository;

  GetBalance(this.repository);

  @override
  Future<Either<Failure, CoinBalance>> call(NoParams params) {
    return repository.getCurrentBalance();
  }
}
