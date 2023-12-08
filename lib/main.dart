import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutterdesktop/home.dart';

void main(List<String> args) {
  if (runWebViewTitleBarWidget(args)) {
    return;
  }
  runApp(const Home());
  doWhenWindowReady(() {
    const initialSize = Size(600, 450);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
