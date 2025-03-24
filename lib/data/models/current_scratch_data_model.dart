/*
class CurrentScratchDataModel extends CurrentScratchDataEntity {
  const CurrentScratchDataModel({
    required super.lastScratchTime,
    required super.nextScratchTime,
    required super.currentCoins,
    required super.rewardCoins,
    required super.isEligibleForScratch,
  });

  factory CurrentScratchDataModel.fromJson(Map<String, dynamic> json) {
    return CurrentScratchDataModel(
      lastScratchTime: json['lastScratchTime'] != null
          ? DateTime.parse(json['lastScratchTime'])
          : null,
      nextScratchTime: json['nextScratchTime'] != null
          ? DateTime.parse(json['nextScratchTime'])
          : null,
      currentCoins: json['currentCoins'] ?? 0,
      rewardCoins: json['rewardCoins'] ?? 0,
      isEligibleForScratch: json['isEligibleForScratch'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastScratchTime': lastScratchTime?.toIso8601String(),
      'nextScratchTime': nextScratchTime?.toIso8601String(),
      'currentCoins': currentCoins,
      'rewardCoins': rewardCoins,
      'isEligibleForScratch': isEligibleForScratch,
    };
  }
}
*/
