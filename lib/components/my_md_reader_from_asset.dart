import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:async' show Future;
import 'package:http/http.dart' as http;

class MyMdReaderFromAsset extends StatelessWidget {
  MyMdReaderFromAsset({Key? key, required this.asset_src, }) : super(key: key);
  String asset_src;

  Future<String> getTextData() async{
    var url = Uri.parse(asset_src);
    var response = await http.get(url);
    return response.body;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Center(child: page_titlewidget)),
        body: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString(asset_src),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Markdown(data: snapshot.data.toString());
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        ));
  }
}
