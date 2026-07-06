import 'package:flo_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import '../../../../core/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(navigationShell.currentIndex),
      backgroundColor: context.colors.background,
      body: navigationShell,
      bottomNavigationBar: CustomBottomAppBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 14),
        child: FloatingActionButton(
          onPressed: () {
            final state = context.read<HomeCubit>().state;
            if (state.user != null) {
              context.push(
                AppConstants.kQrScannerView,
                extra: {
                  AppExtraKeys.kCurrentUserId: state.user!.uId,
                  AppExtraKeys.kCurrentUserName: state.user!.name,
                },
              );
            }
          },
          backgroundColor: context.colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            size: 28,
            Icons.qr_code_scanner,
            color: context.colors.background,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
