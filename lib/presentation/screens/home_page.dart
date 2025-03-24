// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:moonrider_task/presentation/blocs/home/scratch_redeem_history_bloc.dart';
// import 'package:moonrider_task/presentation/blocs/home/scratch_redeem_history_state.dart';
// import 'dart:math';

// import '../widgets/scratch_card.dart';
// import 'history_screen.dart';
// import 'redemption_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int currentIndex = 0;

//   String title = "Collect";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (value) {
//           setState(() {
//             currentIndex = value;
//             if (currentIndex == 0) {
//               title = "Collect";
//             } else if (currentIndex == 1) {
//               title = "Redeem Coins";
//             } else {
//               title = "History";
//             }
//           });
//         },
//         selectedItemColor: Colors.purple[700],
//         items: const [
//           BottomNavigationBarItem(
//             label: 'Coins',
//             icon: Icon(Icons.menu),
//           ),
//           BottomNavigationBarItem(
//             label: 'Rewards',
//             icon: Icon(
//               Icons.add,
//             ),
//           ),
//           BottomNavigationBarItem(
//             label: 'History',
//             icon: Icon(
//               Icons.history,
//             ),
//           ),
//         ],
//       ),
//       appBar: AppBar(
//         title: Text(
//           title,
//           style: TextStyle(
//             color: Colors.purple[700],
//             fontSize: 30,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: BlocBuilder<RewardCoinBloc, RewardCoinState>(
//         builder: (context, state) {
//           if (currentIndex == 0) {
//             return const CoinScreen();
//           } else if (currentIndex == 1) {
//             return const RedemptionScreen();
//           }
//           return const HistoryScreen();
//         },
//       ),
//     );
//   }
// }

// class CoinScreen extends StatelessWidget {
//   const CoinScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RewardCoinBloc, RewardCoinState>(
//       builder: (context, state) {
//         if (state is! TotalCoinState) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color.fromARGB(255, 123, 31, 162),
//                 Color.fromARGB(255, 74, 20, 140)
//               ],
//             ),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Current Balance',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white70,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '${state.coins} coins',
//                       style: const TextStyle(
//                         fontSize: 36,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(32),
//                       topRight: Radius.circular(32),
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Daily Reward',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.purple[700],
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         ScratchCard(
//                           isEnabled: state.lastScratchTime == null ||
//                               DateTime.now()
//                                       .difference(state.lastScratchTime!)
//                                       .inHours >=
//                                   1,
//                           rewardAmount: state.currentRewardAmount ??
//                               (Random().nextInt(451) +
//                                   50), // Use state value if available
//                           nextAvailableTime: state.lastScratchTime?.add(
//                             const Duration(hours: 1),
//                           ),
//                           onScratchComplete: (reward) {
//                             context
//                                 .read<HomeBloc>()
//                                 .add(ScratchCardEvent(reward));
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/home/scratch_redeem_history_bloc.dart';
import '../blocs/home/scratch_redeem_history_state.dart';
import 'history_screen.dart';
// import 'redemption_screen.dart';
import 'coin_screen.dart';
import 'redemption_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<String> _titles = ["Collect", "Redeem Coins", "History"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: Colors.purple[700],
        items: const [
          BottomNavigationBarItem(label: 'Coins', icon: Icon(Icons.menu)),
          BottomNavigationBarItem(label: 'Rewards', icon: Icon(Icons.add)),
          BottomNavigationBarItem(label: 'History', icon: Icon(Icons.history)),
        ],
      ),
      appBar: AppBar(
        title: Text(
          _titles[currentIndex],
          style: TextStyle(
            color: Colors.purple[700],
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<RewardCoinBloc, RewardCoinState>(
        builder: (context, state) {
          if (state is RewardCoinError) {
            return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16)),
            );
          }
          return IndexedStack(
            index: currentIndex,
            children: const [
              CoinScreen(),
              RedemptionScreen(),
              HistoryScreen(),
            ],
          );
        },
      ),
    );
  }
}
