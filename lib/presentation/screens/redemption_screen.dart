import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/current_scratch_data.dart';
import '../blocs/home/scratch_redeem_history_bloc.dart';
import '../blocs/home/scratch_redeem_history_event.dart';
import '../blocs/home/scratch_redeem_history_state.dart';

class RedemptionItem {
  final String name;
  final int coinCost;
  final String description;
  final IconData icon;

  RedemptionItem({
    required this.name,
    required this.coinCost,
    required this.description,
    required this.icon,
  });
}

class RedemptionScreen extends StatefulWidget {
  const RedemptionScreen({super.key});

  @override
  State<RedemptionScreen> createState() => _RedemptionScreenState();
}

class _RedemptionScreenState extends State<RedemptionScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _horizontalController;
  late ScrollController _verticalController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late List<RedemptionItem> items;
  String? _lastRedeemedItem;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupScrollControllers();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _initializeData() {
    items = [
      RedemptionItem(
        name: 'Discount Coupon',
        coinCost: 500,
        description: '10% off on your next ride',
        icon: Icons.local_offer,
      ),
      RedemptionItem(
        name: 'Gift Card',
        coinCost: 1000,
        description: 'Rs. 100 gift card',
        icon: Icons.card_giftcard,
      ),
      RedemptionItem(
        name: 'Free Ride',
        coinCost: 1500,
        description: 'One free ride up to 5km',
        icon: Icons.directions_bike,
      ),
      RedemptionItem(
        name: 'Premium Membership',
        coinCost: 2000,
        description: 'Get a one-month premium membership with exclusive perks',
        icon: Icons.star,
      ),
    ];
  }

  void _setupScrollControllers() {
    _horizontalController = ScrollController();
    _verticalController = ScrollController();

    _horizontalController.addListener(_syncScrolling);
    _verticalController.addListener(_syncScrolling);
  }

  void _syncScrolling() {
    if (!_horizontalController.hasClients || !_verticalController.hasClients) {
      return;
    }

    if (!_horizontalController.position.isScrollingNotifier.value) {
      final scrollPercentage = _verticalController.offset /
          (_verticalController.position.maxScrollExtent);
      _horizontalController.jumpTo(
        scrollPercentage * _horizontalController.position.maxScrollExtent,
      );
    } else if (!_verticalController.position.isScrollingNotifier.value) {
      final scrollPercentage = _horizontalController.offset /
          (_horizontalController.position.maxScrollExtent);
      _verticalController.jumpTo(
        scrollPercentage * _verticalController.position.maxScrollExtent,
      );
    }
  }

  //
  // Show Success Snackbar
  void _showRedemptionSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully redeemed $_lastRedeemedItem!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

//
//

  void _showRedemptionDialog(BuildContext context, RedemptionItem item) {
    // print('### ShowDialog In Start step ::::');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Redeem ${item.name}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cost: ${item.coinCost} coins'),
            const SizedBox(height: 8),
            Text(item.description),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              // color: Colors.grey,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey[300],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: const Text('Cancel'),
            ),
          ),
          FilledButton(
            onPressed: () {
              _lastRedeemedItem = item.name;
              context.read<RewardCoinBloc>().add(
                    RedeemOfferEvent(
                      cost: item.coinCost,
                    ),
                  );
              Navigator.pop(context);
              _showRedemptionSuccessSnackbar();
              _animationController.forward().then((_) {
                _animationController.reset();
                _lastRedeemedItem = null;
              });
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

//
//
  Widget _buildHorizontalItem(int index, int currentBalance) {
    final item = items[index];
    final bool canAfford = currentBalance >= item.coinCost;

    return ScaleTransition(
      scale: _lastRedeemedItem == item.name
          ? _scaleAnimation
          : const AlwaysStoppedAnimation(1.0),
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: canAfford
                ? [Colors.purple[700]!, Colors.purple[900]!]
                : [Colors.grey[400]!, Colors.grey[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: (canAfford ? Colors.purple : Colors.grey).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 32,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              '${item.coinCost}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'coins',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

//
//
  Widget _buildVerticalItem(int index, int currentBalance) {
    final item = items[index];
    final bool canAfford = currentBalance >= item.coinCost;

    return ScaleTransition(
      scale: _lastRedeemedItem == item.name
          ? _scaleAnimation
          : const AlwaysStoppedAnimation(1.0),
      child: Container(
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
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: canAfford ? Colors.purple[50] : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              color: canAfford ? Colors.purple[700] : Colors.grey,
            ),
          ),
          title: Text(
            item.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: canAfford ? Colors.black : Colors.grey,
            ),
          ),
          subtitle: Text(
            item.description,
            style: TextStyle(
              color: canAfford ? Colors.grey[600] : Colors.grey[400],
            ),
          ),
          trailing: FilledButton(
            onPressed:
                canAfford ? () => _showRedemptionDialog(context, item) : null,
            child: Text('${item.coinCost} coins'),
          ),
        ),
      ),
    );
  }
  // Bloc State

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardCoinBloc, RewardCoinState>(
      builder: (context, state) {
        if (state is RewardCoinError) {
          return const Center(
            child: Text(
              'No Offers Yet',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
          );
        }

        int currentCoins = CurrentScratchDataEntity.instance.currentCoins;
        // int currentCoins =
        // state is ScratchCardCoinsState ? state.newBalance : 0;

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
                height: 200,
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ListView.builder(
                  controller: _horizontalController,
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) =>
                      _buildHorizontalItem(index, currentCoins),
                ),
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: ListView.builder(
                    controller: _verticalController,
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) =>
                        _buildVerticalItem(index, currentCoins),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

//
  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    _animationController.dispose();
    super.dispose();
  }
//
}
