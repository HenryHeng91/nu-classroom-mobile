import 'package:meta/meta.dart';

import 'models.dart';

@immutable
class AppState{
  User user;

  AppState(this.user);

}