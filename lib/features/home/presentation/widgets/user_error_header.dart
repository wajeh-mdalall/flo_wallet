import 'package:flo_wallet/features/home/presentation/widgets/custom_user_list_tile.dart';
import 'package:flo_wallet/core/widgets/error_text_widget.dart';
import 'package:flutter/material.dart';

class UserErrorHeader extends StatelessWidget {
  final VoidCallback onRefresh;
  const UserErrorHeader({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomUserListTile(name: "Valued Customer", onRefresh: onRefresh),
          SizedBox(height: 36),
          ErrorTextWidget(),
        ],
      ),
    );
  }
}
