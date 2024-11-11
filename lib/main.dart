// It is the package of libraries to import it so that it will not give an error.

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// It allows us to run the main app which we have made.

void main() {
  runApp(const MyApp());
}

// The StatelessWidget represents the entire app.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  // It defines the UI structure of My App.
  Widget build(BuildContext context) {
    return MaterialApp(
      // The main app widget that sets the application’s title, theme, and home screen.
      title: 'Holy Cross App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //  Hides the debug banner in the top right corner when set to.
      debugShowCheckedModeBanner: false,
      // Sets the main screen of the app to SchoolWeb View.
      home: const SchoolWebView(),
    );
  }
}

class SchoolWebView extends StatefulWidget {
  const SchoolWebView({super.key});

  @override
  State<SchoolWebView> createState() => _SchoolWebViewState();
}

//  Holds the state for SchoolWebView. This is where the WebView controller and state management logic are defined.
class _SchoolWebViewState extends State<SchoolWebView> {
  //  The WebViewController is used to manage the WebView’s behavior.
  final WebViewController controller = WebViewController()
    // Enables JavaScript in the WebView. Setting it to unrestricted allows the WebView to run JavaScript on websites.
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //  Sets up navigation rules for the WebView.
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    // Loads the specified URL (http://holycrossbb.com/) with caching disabled by setting headers to prevent caching. This ensures that the latest version of the page is displayed each time it is loaded.
    ..loadRequest(
      Uri.parse('http://holycrossbb.com/'),
      headers: {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0'
      },
    );

  // This overridden setState() function is redundant here and can be omitted. It would normally be used to trigger UI updates in response to state changes.
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  // Defines the UI structure for _SchoolWebViewState.
  Widget build(BuildContext context) {
    //  Ensures that the WebView content does not overlap with system UI elements, such as the status bar.
    return SafeArea(
      child: Scaffold(
        // WebViewWidget: Displays the web page content in the app, controlled by the controller.
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
