import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moonrider_task/domain/usecases/get_balance.dart';
import 'package:moonrider_task/domain/usecases/scratch_card_usecase.dart';
import 'package:moonrider_task/domain/usecases/redeem_offer_usecase.dart';
import 'package:moonrider_task/domain/usecases/get_transaction_history.dart';
import 'package:moonrider_task/domain/entities/transaction.dart';

import '../../../core/usecase/usecase.dart';
import 'scratch_redeem_history_event.dart';
import 'scratch_redeem_history_state.dart';

class RewardCoinBloc extends Bloc<RewardCoinEvent, RewardCoinState> {
  final GetBalance getBalance;
  final ScratchCardUseCase scratchCardUseCase;
  final RedeemOfferUseCase redeemOfferUseCase;
  final GetTransactionHistory getTransactionHistory;

  int _currentBalance = 1000;
  final List<Transaction> _transactions = [];

  RewardCoinBloc({
    required this.getBalance,
    required this.scratchCardUseCase,
    required this.redeemOfferUseCase,
    required this.getTransactionHistory,
  }) : super(TotalCoinState(coins: 1000)) {
    on<InitialCoinsEvent>((event, emit) async {
      final result = await getBalance(NoParams());
      result.fold(
        (failure) => emit(RewardCoinError(message: "Failed to load balance")),
        (coins) {
          _currentBalance = coins.coins;

          emit(TotalCoinState(coins: _currentBalance));
        },
      );
    });

    on<RedeemScratchCardEvent>((event, emit) async {
      final result = await scratchCardUseCase(NoParams());
      result.fold(
        (failure) => emit(RewardCoinError(message: "Scratch failed")),
        (earnedCoins) {
          _currentBalance += earnedCoins;
          final transaction = Transaction(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            type: TransactionType.scratchReward,
            amount: earnedCoins,
            date: DateTime.now(),
          );
          _transactions.add(transaction);

          emit(ScratchCardCoinsState(
              spentCoins: -earnedCoins, newBalance: _currentBalance));
          emit(TotalCoinState(coins: _currentBalance));
          emit(RedeemHistoryState(transactionList: List.from(_transactions)));
          // emit(TotalCoinState(coins: _currentBalance));
        },
      );
    });

    on<RedeemOfferEvent>((event, emit) async {
      if (_currentBalance >= event.cost) {
        _currentBalance -= event.cost;
        final transaction = Transaction(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: TransactionType.redemption,
          amount: -event.cost,
          date: DateTime.now(),
        );
        print(
            '## Inside Bloc , RedeemOfferEvent before Pushing Transaction ::   ##');
        _transactions.add(transaction);
        final result = await redeemOfferUseCase.call(event.cost);
        result.fold(
            (failure) => emit(RewardCoinError(message: "Insufficient Balance")),
            (re) {
          print(
              '## Inside Bloc , RedeemOfferEvent After Pushing Transaction ::   ##');

          emit(TotalCoinState(coins: _currentBalance));
          emit(RedeemHistoryState(transactionList: List.from(_transactions)));
        });
      }
    });

    on<RedeemHistoryEvent>((event, emit) async {
      emit(RedeemHistoryState(transactionList: List.from(_transactions)));
    });
  }
}
