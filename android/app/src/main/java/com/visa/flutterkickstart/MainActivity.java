package com.visa.flutterkickstart;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private Map<String, String> sharedData = new HashMap();
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    // Handle intent when app is initially opened
    handleSendIntent(getIntent());

    new MethodChannel(getFlutterView(), "app.channel.shared.data").setMethodCallHandler(
            (call, result) -> {
              if (call.method.contentEquals("getSharedData")) {
                result.success(sharedData);
                sharedData.clear();
              }
            }
    );
  }

  @Override
  protected void onNewIntent(Intent intent) {
    // Handle intent when app is resumed
    super.onNewIntent(intent);
    handleSendIntent(intent);
  }

  private void handleSendIntent(Intent intent) {
    try{
      String action = intent.getAction();
      String type = intent.getType();
      String path = intent.getData().getPath();
      Log.d("Main", "handleSendIntent: "+path);

      String classId = path.substring(path.lastIndexOf("/")+1);
      Log.d("Main", "handleSendIntent: classId "+classId);

      sharedData.put("subject", "JOIN_CLASS");
      sharedData.put("classId", classId);
    }catch (Exception e){
      //
    }
  }
}
