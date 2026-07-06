import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/injection/core_di.dart';
import 'package:flo_wallet/core/helper/my_bloc_observer.dart';
import 'package:flo_wallet/core/theme/cubit/theme_cubit.dart';
import 'core/router/app_router.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/cache/cache_helper.dart';
import 'core/injection/service_locator.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  await getIt<CacheHelper>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()..getCurrentUser()),
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) =>
            AppStyles.themeColorsNotifier.value = state.colors,
        builder: (context, state) {
          return ValueListenableBuilder(
            valueListenable: AppStyles.themeColorsNotifier,
            builder: (context, value, child) => MaterialApp.router(
              key: ValueKey(state.isDarkMode),
              theme: AppStyles.themeData,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
            ),
          );
        },
      ),
    );
  }
}
