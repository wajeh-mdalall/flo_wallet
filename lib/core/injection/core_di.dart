import '../network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../cache/cache_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupCoreDI() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerSingleton<NetworkInfo>(
    NetworkInfoImpl(InternetConnectionChecker.instance),
  );
}




