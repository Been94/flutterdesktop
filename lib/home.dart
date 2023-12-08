import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: WindowBorder(
            color: Colors.grey,
            width: 1,
            child: const Row(
              children: [
                RightSide(),
              ],
            ),
          ),
        ));
  }
}

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);

  void codeTest() async {
    final webview = await WebviewWindow.create(
      configuration: const CreateConfiguration(
        windowHeight: 700,
        windowWidth: 390,
        windowPosX: 0,
        windowPosY: 0,
        openMaximized: false,
        title: "InstaLogin",
      ),
    );
    webview.launch(
        "https://api.instagram.com/oauth/authorize?client_id=3242483672723262&redirect_uri=https://jamkrafters.github.io/homepage/&scope=user_profile,user_media&response_type=code");
    webview.addOnUrlRequestCallback((url) {
      final uri = Uri.parse(url);
      if (uri.path == '/homepage/') {
        debugPrint('login success. token: ${uri.queryParameters['code']}');
        webview.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        WindowTitleBarBox(
          child: Row(
            children: [
              Expanded(child: MoveWindow()),
              const WindowButtons(),
            ],
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              codeTest();
            },
            child: const Text("InstaLogin"),
          ),
        ),
      ]),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
