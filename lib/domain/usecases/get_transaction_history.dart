import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/reward_repository.dart';
import '../entities/transaction.dart';
import '../../core/usecase/usecase.dart';

class GetTransactionHistory extends UseCase<List<Transaction>, NoParams> {
  final RewardRepository repository;

  GetTransactionHistory(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) async {
    return repository.getTransactionHistory();
  }
}
