import 'package:flutter/material.dart';

import 'env/config.dart';

class AppConfig extends InheritedWidget {
  AppConfig({Key key, @required this.config, @required Widget child})
      : assert(config != null),
        assert(child != null),
        super(key: key, child: child);

  final Config config;

  @override
  bool updateShouldNotify(AppConfig oldWidget) => config != oldWidget.config;
}