package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.mr.flutter.plugin.filepicker.FilePickerPlugin;
import com.peerwaya.flutteraccountkit.FlutterAccountKitPlugin;
import zhuoyuan.li.fluttershareme.FlutterShareMePlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FilePickerPlugin.registerWith(registry.registrarFor("com.mr.flutter.plugin.filepicker.FilePickerPlugin"));
    FlutterAccountKitPlugin.registerWith(registry.registrarFor("com.peerwaya.flutteraccountkit.FlutterAccountKitPlugin"));
    FlutterShareMePlugin.registerWith(registry.registrarFor("zhuoyuan.li.fluttershareme.FlutterShareMePlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
