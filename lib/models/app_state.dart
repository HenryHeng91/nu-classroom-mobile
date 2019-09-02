import 'package:meta/meta.dart';

import 'models.dart';

@immutable
class AppState{
  List<Service> services;

  AppState(this.services);

}