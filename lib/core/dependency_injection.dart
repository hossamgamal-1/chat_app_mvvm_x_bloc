import 'package:chat_app/data/web_services.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

gitInit() {
  getIt.registerLazySingleton<WebServices>(() => WebServices());
}
