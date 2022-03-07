//url : https://newsapi.org/
//method (url) : v2/top-headlines?
//query: country=eg&category=business&apiKey=4c942b69a7d94b92817fb921602ca03a

// https://newsapi.org/v2/everything?q=tesla&apiKey=4c942b69a7d94b92817fb921602ca03a

import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/web_view/web_view_screen.dart';

Widget buildRow(article, context) => InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: WebViewScreen(article['url']))));
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
              child: CachedNetworkImage(
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                imageUrl: '${article['urlToImage']}',
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                //errorWidget: (context, url, error) => const Icon(Icons.error),
                errorWidget: (context, url, error) => Image.asset('assets/logo.png'),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )),
                    Text('${article['publishedAt']}',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget articleBuilder(list) => BuildCondition(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        key: const PageStorageKey<String>('page'),
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return buildRow(list[index], context);
        },
      ),
      fallback: (context) =>
          const Center(child: Center(child: CircularProgressIndicator())),
    );
