import 'package:firebase_core/firebase_core.dart';
import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/injection/core_di.dart';
import 'package:flo_wallet/core/helper/my_bloc_observer.dart';
import 'core/router/app_router.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/cache/cache_helper.dart';
import 'core/injection/service_locator.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  await getIt<CacheHelper>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..getCurrentUser(),
      child: MaterialApp.router(
        theme: ThemeData(canvasColor: AppColors.background),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
