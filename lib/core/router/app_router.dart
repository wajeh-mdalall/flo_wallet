import 'package:flo_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flo_wallet/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:flo_wallet/features/transactions/presentation/cubit/qr_scanner_cubit/qr_scanner_cubit.dart';
import 'package:flo_wallet/features/transactions/presentation/cubit/transactions_cubit/transactions_cubit.dart';
import 'package:flo_wallet/features/transactions/presentation/views/qr_scanner_view.dart';
import 'package:flo_wallet/features/transactions/presentation/views/send_money_amount_view.dart';
import 'package:flo_wallet/features/transactions/presentation/views/transactions_view.dart';
import 'package:flo_wallet/features/user/presentation/cubit/user_search_cubit/user_search_cubit.dart';
import 'package:flo_wallet/features/user/presentation/views/profile_view.dart';
import 'package:flo_wallet/features/user/presentation/views/user_search_view.dart';
import 'package:flo_wallet/features/wallet/presentation/views/wallet_view.dart';
import '../injection/core_di.dart';
import '../../features/home/presentation/views/main_scaffold.dart';
import '../../features/transactions/presentation/cubit/send_money_cubit/send_money_cubit.dart';
import '../../features/user/presentation/cubit/user_profile_management_cubit/user_profile_management_cubit.dart';
import '../../features/user/presentation/views/complete_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../../features/auth/presentation/views/auth_gate_view.dart';
import '../../features/auth/presentation/views/phone_number_view.dart';
import '../../features/auth/presentation/views/verify_otp_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/",
    routes: [
      GoRoute(path: "/", builder: (context, state) => AuthGateView()),
      GoRoute(
        path: AppConstants.kOnboardingView,
        builder: (context, state) => OnboardingView(),
      ),
      GoRoute(
        path: AppConstants.kPhoneNumberView,
        builder: (context, state) => PhoneNumberView(),
      ),
      GoRoute(
        path: AppConstants.kVerifyOtpView,
        builder: (context, state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return VerifyOtpView(
            phoneNumber: data[AppExtraKeys.kPhoneNumber],
            verificationId: data[AppExtraKeys.kVerificationId],
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BlocProvider.value(
            value: getIt<HomeCubit>(),
            child: MainScaffold(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppConstants.kHomeView,
                name: AppConstants.kHomeView,
                builder: (context, state) {
                  return const HomeView();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppConstants.kTransactionsView,
                builder: (context, state) {
                  return BlocProvider(
                    create: (context) => getIt<TransactionsCubit>(),
                    child: const TransactionsView(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppConstants.kWalletView,
                builder: (context, state) {
                  return const WalletView();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppConstants.kProfileView,
                builder: (context, state) {
                  return const ProfileView();
                },
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: AppConstants.kCompleteProfile,
        builder: (context, state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (context) => getIt<UserProfileManagementCubit>(),
            child: CompleteProfileView(
              uId: data[AppExtraKeys.kUId],
              phoneNumber: data[AppExtraKeys.kPhoneNumber],
              userEntity: data[AppExtraKeys.kUser],
            ),
          );
        },
      ),
      GoRoute(
        path: AppConstants.kQrScannerView,
        builder: (context, state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (context) => QrScannerCubit(),
            child: QrScannerView(
              currentUserId: data[AppExtraKeys.kCurrentUserId],
              currentUserName: data[AppExtraKeys.kCurrentUserName],
            ),
          );
        },
      ),
      GoRoute(
        path: AppConstants.kSendMoneyAmountView,
        builder: (context, state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (context) => getIt<SendMoneyCubit>(),
            child: SendMoneyAmountView(
              senderId: data[AppExtraKeys.kSenderId],
              senderName: data[AppExtraKeys.kSenderName],
              receiverId: data[AppExtraKeys.kReceiverId],
              receiverName: data[AppExtraKeys.kReceiverName],
              receiverProfileImage: data[AppExtraKeys.kReceiverProfileImage],
            ),
          );
        },
      ),
      GoRoute(
        path: AppConstants.kUserSearchView,
        builder: (context, state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (context) => getIt<UserSearchCubit>(),
            child: UserSearchView(
              currentUserId: data[AppExtraKeys.kCurrentUserId],
              currentUserName: data[AppExtraKeys.kCurrentUserName],
              currentUserPhoneNumber:
                  data[AppExtraKeys.kCurrentUserPhoneNumber],
            ),
          );
        },
      ),
    ],
  );
}
