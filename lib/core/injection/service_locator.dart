import 'core_di.dart';
import '../../features/auth/injection/auth_di.dart';

void setupServiceLocator() {
  setupCoreDI();
  setupAuthDI();
}