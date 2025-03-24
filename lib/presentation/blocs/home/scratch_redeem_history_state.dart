import 'package:equatable/equatable.dart';
import 'package:moonrider_task/domain/entities/transaction.dart';

import '../../../domain/entities/current_scratch_data.dart';

abstract class RewardCoinState extends Equatable {
  @override
  List<Object?> get props => [];
}

//  Initial state with total coins
class TotalCoinState extends RewardCoinState {
  final int coins;

  TotalCoinState({required this.coins});

  @override
  List<Object?> get props => [coins];
}

// state for last scratch time
class LastScratchTimeState extends RewardCoinState {
  final DateTime? lastScratchTime;

  LastScratchTimeState(this.lastScratchTime);
}

//  Scratch card action
class ScratchCardCoinsState extends RewardCoinState {
  final int spentCoins;
  final int newBalance;

  ScratchCardCoinsState({required this.spentCoins, required this.newBalance});

  @override
  List<Object?> get props => [spentCoins, newBalance];
}

//  Transaction history
class RedeemHistoryState extends RewardCoinState {
  final List<Transaction> transactionList;

  RedeemHistoryState({required this.transactionList});

  @override
  List<Object?> get props => [transactionList];
}

// Error state
class RewardCoinError extends RewardCoinState {
  final String message;

  RewardCoinError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Offer redeemed success
class OfferRedeemed extends RewardCoinState {
  final int spentCoins;
  final int newBalance;

  OfferRedeemed({required this.spentCoins, required this.newBalance});

  @override
  List<Object?> get props => [spentCoins, newBalance];
}

class ScratchCardState extends RewardCoinState {
  final CurrentScratchDataEntity data;

  ScratchCardState({required this.data});

  @override
  List<Object?> get props => [data];
}
