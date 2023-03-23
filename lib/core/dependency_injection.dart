import 'package:get_it/get_it.dart';

import '../data/web_services.dart';

final sL = GetIt.instance;

gitInit() {
  sL.registerLazySingleton<BaseWebServices>(() => WebServices());
}
