import 'package:flutter/material.dart';

import 'app_config.dart';
import 'env/config.dart';

class ConfigWrapper extends StatelessWidget {
  ConfigWrapper({Key key, this.config, this.child});

  @override
  Widget build(BuildContext context) {
    return new AppConfig(config: this.config, child: this.child);
  }

  static Config of(BuildContext context) {
    final AppConfig appConfig =
    context.inheritFromWidgetOfExactType(AppConfig);
    return appConfig.config;
  }

  final Config config;
  final Widget child;
}