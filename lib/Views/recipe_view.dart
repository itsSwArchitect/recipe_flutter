import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  @override
  final postUrl;
  RecipeView({this.postUrl});

  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  String finalUrl;
  final Completer<WebViewController> completer = Completer<WebViewController>();

  void initState() {

    if (widget.postUrl.contains('http//')) {
      finalUrl = widget.postUrl.replaceAll('http//', 'https//');
    } else {
      finalUrl = widget.postUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).copyWith().size.width,
            height: MediaQuery.of(context).copyWith().size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xffFF9999),
              Color(0xffFF6666),
            ])),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: WebView(
                      initialUrl: finalUrl,
                      onWebViewCreated: (WebViewController webviewcontoller) {
                        setState(() {
                          completer.complete(webviewcontoller);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
