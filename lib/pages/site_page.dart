import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class sitePage extends StatefulWidget {

  @override
  _sitePageState createState() => _sitePageState();
}

class _sitePageState extends State<sitePage> {
  WebViewController controller;
  var _stackIdx = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Site"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),onPressed: _onClickRefresh,)
        ],
      ),
      body: _buildWebView(),
    );
  }

  _buildWebView() {
    return IndexedStack(
      index: _stackIdx,
      children: [
        Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: "http://google.com",
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
                onPageFinished: _OnPagefinished,
              ),
            ),
          ],
        ),
        Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  void _onClickRefresh() {
    //recarrega a pagina
    this.controller.reload();
  }

  void _OnPagefinished(String url) {

    setState(() {
      _stackIdx = 0;
    });

  }
}
