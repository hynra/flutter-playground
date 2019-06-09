import 'package:dependencies/dependencies.dart';

import 'comment/service.dart';
import 'post/service.dart';
import 'user/service.dart';

class ServiceModule implements Module {
  @override
  void configure(Binder binder) {
    binder.bindSingleton("https://jsonplaceholder.typicode.com",
        name: "api_root");
    binder.bindLazySingleton<PostService>((injector, params) {
      return PostRestService(injector);
    });
    binder.bindLazySingleton<UserService>((injector, param){
      return UserRestService(injector);
    });
    binder.bindLazySingleton<CommentService>((injector, param){
      return CommentRestService(injector);
    });
  }
}
