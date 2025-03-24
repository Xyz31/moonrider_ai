import '../../domain/entities/transaction.dart';
import 'package:equatable/equatable.dart';

class TransactionModel extends Transaction with EquatableMixin {
  const TransactionModel({
    required super.id,
    required super.type,
    required super.amount,
    required super.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      type: TransactionType.values[json['type']],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, type, amount, date];
}
