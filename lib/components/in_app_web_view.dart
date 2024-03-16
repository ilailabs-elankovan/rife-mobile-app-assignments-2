// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:http/http.dart';
// import 'dart:core';
//
//
// class WebpageViewer extends StatefulWidget {
//   final String pageUrl;
//
//   WebpageViewer({required this.pageUrl});
//
//   @override
//   _WebpageViewerState createState() => _WebpageViewerState();
// }
//
// class _WebpageViewerState extends State<WebpageViewer> {
//   InAppWebViewController? _webViewController;
//
//   @override
//   Widget build(BuildContext context) {
//     Uri myurl = Uri.parse(widget.pageUrl);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Webpage Viewer"),
//       ),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: myurl),
//         initialOptions: InAppWebViewGroupOptions(
//           crossPlatform: InAppWebViewOptions(
//           ),
//         ),
//         onWebViewCreated: (controller) {
//           _webViewController = controller;
//         },
//       ),
//     );
//   }
// }
