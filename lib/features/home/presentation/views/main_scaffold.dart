import 'package:flo_wallet/core/services/notification_service.dart';
import 'package:flo_wallet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flo_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import '../../../../core/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainScaffold({super.key, required this.navigationShell});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  void initState() {
    super.initState();
    NotificationService.requestPermissions();
    final authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      context.read<HomeCubit>().fetchHomeData(uId: authState.authUser.uId);
    }
    NotificationService.onNotificationClicked = () {
    if (mounted) {
      widget.navigationShell.goBranch(1, initialLocation: true);
    }
  };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(widget.navigationShell.currentIndex),
      backgroundColor: context.colors.background,
      body: widget.navigationShell,
      bottomNavigationBar: CustomBottomAppBar(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
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
