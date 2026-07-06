import 'package:flutter/material.dart';

class TransactionIconDesign {
  final IconData icon;
  final Color color;

  TransactionIconDesign({required this.icon, required this.color});
}

class TransactionUIHelper {
  static TransactionIconDesign getIconDesign(String category) {
    final text = category.trim().toLowerCase();

    if (text.contains('gift') || text.contains('present')) {
      return TransactionIconDesign(
        icon: Icons.card_giftcard,
        color: const Color(0xFFFFCCBC),
      );
    }

    if (text.contains('coffee') || text.contains('cafe')) {
      return TransactionIconDesign(
        icon: Icons.coffee,
        color: const Color(0xFFD7CCC8),
      );
    }

    if (text.contains('food') ||
        text.contains('restaurant') ||
        text.contains('dinner')) {
      return TransactionIconDesign(
        icon: Icons.restaurant,
        color: const Color(0xFFFFE082),
      );
    }

    if (text.contains('shopping') ||
        text.contains('shop') ||
        text.contains('store') ||
        text.contains('buy') ||
        text.contains('market')) {
      return TransactionIconDesign(
        icon: Icons.shopping_bag,
        color: const Color(0xFFA7FFEB),
      );
    }

    if (text.contains('salary') ||
        text.contains('income') ||
        text.contains('bonus')) {
      return TransactionIconDesign(
        icon: Icons.attach_money,
        color: const Color(0xC8A5D6A7),
      );
    }

    if (text.contains('bill') ||
        text.contains('invoice') ||
        text.contains('electricity') ||
        text.contains('internet')) {
      return TransactionIconDesign(
        icon: Icons.receipt_long,
        color: const Color(0xFFFFCDD2),
      );
    }

    if (text.contains('transfer') ||
        text.contains('send') ||
        text.contains('receive')) {
      return TransactionIconDesign(
        icon: Icons.swap_horiz,
        color: const Color(0xFFE1BEE7),
      );
    }

    if (text.contains('investment') ||
        text.contains('trade') ||
        text.contains('stock')) {
      return TransactionIconDesign(
        icon: Icons.candlestick_chart,
        color: const Color(0xFFCFD8DC),
      );
    }

    return TransactionIconDesign(
      icon: Icons.account_balance_wallet,
      color: const Color(0xFFB0BEC5),
    );
  }
}
