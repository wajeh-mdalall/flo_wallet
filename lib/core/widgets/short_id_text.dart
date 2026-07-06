import 'package:flutter/material.dart';

class ShortIdText extends StatelessWidget {
  final String id;
  final double? size;
  final bool withTitle;
  const ShortIdText({
    super.key,
    required this.id,
    this.withTitle = true,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final shortId = "${id.substring(0, 8)}•••";
    return Text(
      withTitle ? "ID: $shortId" : shortId,
      style: TextStyle(
        color: Colors.grey.shade600,
        fontFamily: 'monospace',
        fontSize: size,
      ),
    );
  }
}
