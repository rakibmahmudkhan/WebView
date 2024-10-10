import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Make sure this is the correct version

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Required for platform channels
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewExample(),
    );
  }
}

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize controller
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("In progress: $progress");
          },
          onPageStarted: (String url) {
            debugPrint("Page started loading: $url");
          },
          onPageFinished: (String url) {
            debugPrint("Page finished loading: $url");
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("Error loading page: $error");
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("facebook")) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://netbridgeltd.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
