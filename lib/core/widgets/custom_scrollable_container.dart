import 'package:flutter/material.dart';

class CustomScrollableContainer extends StatelessWidget {
  final Widget child;
  const CustomScrollableContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: child,
      ),
    );
  }
}
