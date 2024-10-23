import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../controllers/auth_controller.dart';
import '../repositories/user_repository.dart';
import '../services/http_service.dart';
import '../services/local_storage_service.dart';

class AppDependency {
  static List<SingleChildWidget> getProviders() {
    return [
      Provider<LocalStorageService>(create: (context) => LocalStorageService()),
      Provider<HttpService>(create: (context) => HttpService()),
      Provider<UserRepository>(
          create: (context) =>
              UserRepository(httpService: context.read<HttpService>())),
      ChangeNotifierProvider<AuthController>(
        create: (context) => AuthController(
          localStorage: context.read<LocalStorageService>(),
          repository: context.read<UserRepository>(),
        ),
      ),
    ];
  }
}
