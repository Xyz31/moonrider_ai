import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/reward_repository.dart';
import '../entities/transaction.dart';

class RedeemOfferUseCase {
  final RewardRepository repository;

  RedeemOfferUseCase(this.repository);

  Future<Either<Failure, void>> call(int cost) async {
    // Fetch the current balance
    final balanceResult = await repository.getCurrentBalance();

    return balanceResult.fold((failure) => Left(failure), (balance) async {
      if (balance.coins < cost) {
        return const Left(ServerFailure("Insufficient balance to redeem"));
      }

      // Create a new transaction entry
      final transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: TransactionType.redemption,
        amount: -cost,
        date: DateTime.now(),
      );

      // Add transaction to history
      await repository.addTransaction(transaction);
      return const Right(null);
    });
  }
}
