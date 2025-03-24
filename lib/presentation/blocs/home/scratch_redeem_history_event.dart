import 'package:equatable/equatable.dart';

abstract class RewardCoinEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fetch initial coins
class InitialCoinsEvent extends RewardCoinEvent {}

// Scratch card event (earn coins)
class RedeemScratchCardEvent extends RewardCoinEvent {
  // final int coinsGot;
  // final DateTime scratchTime;

  // RedeemScratchCardEvent({required this.coinsGot, required this.scratchTime});
}

// Redeem an offer (spend coins)
class RedeemOfferEvent extends RewardCoinEvent {
  final int cost;
  RedeemOfferEvent({required this.cost});

  @override
  List<Object?> get props => [cost];
}

// Fetch transaction history
class RedeemHistoryEvent extends RewardCoinEvent {}
