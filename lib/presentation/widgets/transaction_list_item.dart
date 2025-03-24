import 'package:flutter/material.dart';

import '../../domain/entities/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool isCredit = transaction.type == TransactionType.scratchReward;

    IconData getTransactionIcon() {
      switch (transaction.type) {
        case TransactionType.scratchReward:
          return Icons.card_giftcard;
        // case TransactionType.reward:
        //   return Icons.star;
        case TransactionType.redemption:
          return Icons.redeem;
      }
    }

    String getTransactionTitle() {
      switch (transaction.type) {
        case TransactionType.scratchReward:
          return 'Scratch Card Reward';
        // case TransactionType.reward:
        //   return 'Reward Earned';
        case TransactionType.redemption:
          return 'Item Redemption';
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: isCredit
              ? const Color(0xFF1E88E5).withOpacity(0.1)
              : Colors.red[100],
          child: Icon(
            getTransactionIcon(),
            color: isCredit ? const Color(0xFF1E88E5) : Colors.red,
          ),
        ),
        title: Text(
          getTransactionTitle(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (transaction.type == TransactionType.redemption)
            //   Text(
            //     '${transaction.description}',
            //     style: TextStyle(
            //       color: Colors.grey[600],
            //     ),
            //   ),
            Text(
              _formatDate(transaction.date),
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: Text(
          '${isCredit ? '+' : ''}${transaction.amount}',
          style: TextStyle(
            color: isCredit ? Colors.purple[700] : Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
