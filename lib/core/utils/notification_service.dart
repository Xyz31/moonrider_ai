import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationService {
  static const platform = MethodChannel('com.emotorad/notifications');

  Future<void> showRedemptionNotification(String itemName, int coins) async {
    String title = "Redeemed : $itemName";
    if (itemName.startsWith("Scracth Award")) {
      print(
          '## Notification Service :: ${itemName.compareTo("Scratch Award")} ::::');

      title = "Scratch Award : $coins";
    }
    try {
      await platform.invokeMethod('showNotification', {
        'title': title,
        'body': 'You have successfully redeemed $itemName',
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to show notification: ${e.message}');
    }
  }
}
