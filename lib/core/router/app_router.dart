import '../constants.dart';
import '../../features/auth/presentation/views/auth_gate_view.dart';
import '../../features/auth/presentation/views/phone_number_view.dart';
import '../../features/auth/presentation/views/verify_otp_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(path:"/" , builder: (context, state) => AuthGateView()),
      GoRoute(path: AppConstants.kPhoneNumberView, builder: (context, state) => PhoneNumberView()),
      GoRoute(
        path: AppConstants.kVerifyOtpView,
        builder: (context, state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return VerifyOtpView(
            phoneNumber: data["phoneNumber"],
            verificationId: data["verificationId"],
          );
        },
      ),
      GoRoute(path: AppConstants.kHomeView, builder: (context, state) => HomeView()),
    ],
  );
}
