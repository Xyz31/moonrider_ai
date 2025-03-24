class CurrentScratchDataEntity {
  DateTime? lastScratchTime;
  DateTime? nextScratchTime;
  int currentCoins;
  int rewardCoins;
  bool isEligibleForScratch;

  CurrentScratchDataEntity._(this.lastScratchTime, this.nextScratchTime,
      this.isEligibleForScratch, this.currentCoins, this.rewardCoins);

  static final CurrentScratchDataEntity instance = CurrentScratchDataEntity._(
    null,
    null,
    false,
    1000,
    0,
  );
}

// class CurrentScratchDataEntity {
//   final DateTime? lastScratchTime;
//   final DateTime? nextScratchTime;
//   final int currentCoins;
//   final int rewardCoins;
//   final bool isEligibleForScratch;

//   const CurrentScratchDataEntity({
//     required this.lastScratchTime,
//     required this.nextScratchTime,
//     required this.currentCoins,
//     required this.rewardCoins,
//     required this.isEligibleForScratch,
//   });

//   CurrentScratchDataEntity copyWith({
//     DateTime? lastScratchTime,
//     DateTime? nextScratchTime,
//     int? currentCoins,
//     int? rewardCoins,
//     bool? isEligibleForScratch,
//   }) {
//     return CurrentScratchDataEntity(
//       lastScratchTime: lastScratchTime ?? this.lastScratchTime,
//       nextScratchTime: nextScratchTime ?? this.nextScratchTime,
//       currentCoins: currentCoins ?? this.currentCoins,
//       rewardCoins: rewardCoins ?? this.rewardCoins,
//       isEligibleForScratch: isEligibleForScratch ?? this.isEligibleForScratch,
//     );
//   }
// }
