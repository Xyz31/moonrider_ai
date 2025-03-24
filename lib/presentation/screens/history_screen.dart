// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:moonrider_task/presentation/blocs/home/scratch_redeem_history_bloc.dart';
// import 'package:moonrider_task/presentation/blocs/home/scratch_redeem_history_state.dart';

// class HistoryScreen extends StatelessWidget {
//   const HistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<RewardCoinBloc, RewardCoinState>(
//         builder: (context, state) {
//           return Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color.fromARGB(255, 123, 31, 162),
//                   Color.fromARGB(255, 74, 20, 140)
//                 ],
//               ),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   height: 70,
//                   alignment: Alignment.center,
//                   child: const Text(
//                     'Transaction History',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(32),
//                         topRight: Radius.circular(32),
//                       ),
//                     ),
//                     child: _buildTransactionsList(state),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTransactionsList(RewardCoinState state) {
//     if (state.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (state.transactions.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.history,
//               size: 64,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'No transactions yet',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: state.transactions.length,
//       itemBuilder: (context, index) {
//         final transaction = state.transactions[index];
//         return TransactionCard(transaction: transaction);
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/home/scratch_redeem_history_bloc.dart';
import '../blocs/home/scratch_redeem_history_state.dart';
import '../widgets/transaction_list_item.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RewardCoinBloc, RewardCoinState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 123, 31, 162),
                  Color.fromARGB(255, 74, 20, 140)
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: const Text(
                    'Transaction History',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: _buildTransactionsList(state),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionsList(RewardCoinState state) {
    if (state is RewardCoinError) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    if (state is RedeemHistoryState) {
      if (state.transactionList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No transactions yet',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.transactionList.length,
        itemBuilder: (context, index) {
          int n = state.transactionList.length;
          final transaction = state.transactionList[n - 1 - index];
          return TransactionCard(transaction: transaction);
        },
      );
    }

    return const Center(
      child: Text(
        'No Trancations Yet',
        style: TextStyle(
          fontSize: 24,
          color: Colors.grey,
        ),
      ),
    );
  }
}
