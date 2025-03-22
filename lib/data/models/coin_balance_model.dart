import 'package:equatable/equatable.dart';
import 'package:moonrider_task/domain/entities/coin_balance.dart';

class CoinBalanceModel extends CoinBalance with EquatableMixin {
  const CoinBalanceModel({required super.coins});

  factory CoinBalanceModel.fromJson(Map<String, dynamic> json) {
    return CoinBalanceModel(
      coins: json['coins'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coins': coins,
    };
  }

  @override
  List<Object?> get props => [coins];
}
