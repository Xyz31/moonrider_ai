import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moonrider_task/domain/entities/current_scratch_data.dart';

import '../blocs/home/scratch_redeem_history_bloc.dart';
import '../blocs/home/scratch_redeem_history_event.dart';
import '../blocs/home/scratch_redeem_history_state.dart';
import '../widgets/scratch_card.dart';

class CoinScreen extends StatelessWidget {
  const CoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardCoinBloc, RewardCoinState>(
      builder: (context, state) {
        if (state is RewardCoinError) {
          return Center(
            child: Text(state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16)),
          );
        }
        CurrentScratchDataEntity data = CurrentScratchDataEntity.instance;

        int coinBalance = data.currentCoins;
        print('## CoinScreen :: coinBalance = $coinBalance');

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7B1FA2), Color(0xFF4A148C)],
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text('Current Balance',
                        style: TextStyle(fontSize: 18, color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text(
                      '$coinBalance coins',
                      style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Reward',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Builder(builder: (context) {
                          bool isEligibleForScratch = true;

                          DateTime? lastScratchTime = data.lastScratchTime;

                          if (lastScratchTime != null &&
                              DateTime.now()
                                      .difference(lastScratchTime)
                                      .inHours <
                                  1) {
                            isEligibleForScratch = false;
                          }
                          if (isEligibleForScratch) {
                            return ScratchCard(
                              onScratchComplete: () {
                                print(
                                    '## Inside Scratch , RedeemScratchEvent before Pushing Transaction ::   ##');
                                context
                                    .read<RewardCoinBloc>()
                                    .add(RedeemScratchCardEvent());
                              },
                            );
                          } else {
                            DateTime? nextDate;
                            if (lastScratchTime != null) {
                              nextDate =
                                  lastScratchTime.add(const Duration(hours: 1));
                            }
                            return DataCard(
                              rewardAmount: data.rewardCoins,
                              nextAvailableTime: nextDate ?? DateTime.now(),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
