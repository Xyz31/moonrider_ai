import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moonrider_task/core/constants.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/utils/shared_prefernences.dart';
import 'data/repositories/reward_repository_impl.dart';
import 'domain/entities/current_scratch_data.dart';
import 'domain/repositories/reward_repository.dart';
import 'domain/usecases/get_balance.dart';
import 'domain/usecases/get_transaction_history.dart';
import 'domain/usecases/redeem_offer_usecase.dart';
import 'domain/usecases/scratch_card_usecase.dart';
import 'main.dart';
import 'presentation/blocs/home/scratch_redeem_history_bloc.dart';
import 'presentation/blocs/home/scratch_redeem_history_event.dart';

Future<void> intilializeSharedPref() async {
  final DateTime? date = await SharedPreferencesServices().getLastDate();
  final int? coins = await SharedPreferencesServices()
      .getInteger(AppConstants.LastCoinsPrefKey);
  final int? scratchCoins = await SharedPreferencesServices()
      .getInteger(AppConstants.LastEarnedCoinsPrefKey);

  if (date != null) {
    CurrentScratchDataEntity.instance.lastScratchTime = date;
  }
  if (coins != null) {
    CurrentScratchDataEntity.instance.currentCoins = coins;
  }

  if (scratchCoins != null) {
    CurrentScratchDataEntity.instance.rewardCoins = scratchCoins;
  }
}

Widget initializeRepoReturnMyAPP() {
  // Create repository instance
  final RewardRepository repository = RewardRepositoryImpl();

  // Create use cases
  final getBalance = GetBalance(repository);
  final scratchCardUseCase = ScratchCardUseCase(repository);
  final redeemOfferUseCase = RedeemOfferUseCase(repository);
  final getTransactionHistory = GetTransactionHistory(repository);

  return BlocProvider<RewardCoinBloc>(
    create: (context) => RewardCoinBloc(
      getBalance: getBalance,
      scratchCardUseCase: scratchCardUseCase,
      redeemOfferUseCase: redeemOfferUseCase,
      getTransactionHistory: getTransactionHistory,
    )..add(InitialCoinsEvent()), // Initialize the bloc with initial event
    child: const MyApp(),
  );
}

Future<void> requestNotificationPermission() async {
  var status = await Permission.notification.status;
  if (status.isDenied || status.isPermanentlyDenied) {
    await Permission.notification.request();
  }
}
