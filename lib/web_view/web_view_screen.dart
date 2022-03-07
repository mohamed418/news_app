import 'package:flutter/material.dart';
import 'package:news_app/news_app/news_layout.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

  final String url;
  WebViewScreen(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Directionality(textDirection: TextDirection.rtl, child: NewsLayout())));
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 30,),
          ),
        ],
        title: const Align(alignment:Alignment.topLeft,child: Text('Elabd News')),
      ),
      body: WebView(
        initialUrl: url,
      )
    );
  }
}
