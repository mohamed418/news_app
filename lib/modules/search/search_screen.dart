// ignore_for_file: must_be_immutable

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/models/component.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/cubit/states.dart';
import 'package:news_app/news_app/news_layout.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = NewsCubit.get(context).search;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onChanged: (value) {
                  if (value.isEmpty) {
                    cubit.changeSearchBar();
                  } else {
                    cubit.getSearch(value);
                  }
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'enter any thing you want..',
                  label: Text(
                    'Search',
                    style: TextStyle(color: Colors.grey),
                  ),

                ),
              ),
            ),
            Expanded(
              child: BuildCondition(
                condition: list.isNotEmpty,
                builder: (context) => ListView.separated(
                  key: const PageStorageKey<String>('SearchPage'),
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
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
                fallback: (context) => Center(
                    child: Center(child: Lottie.asset('assets/search.json'),)
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
