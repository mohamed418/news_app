// ignore_for_file: file_names

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/models/component.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).business;
        return BuildCondition(
          condition: list.isNotEmpty,
          builder: (context) => AnimationLimiter(
            child: ListView.separated(
              key: const PageStorageKey<String>('BusinessPage'),
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
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  columnCount: list.length,
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FlipAnimation(
                      child: buildRow(list[index], context),
                    ),
                  ),
                );
              },
            ),
          ),
          fallback: (context) => Center(
              child: Center(child: Lottie.asset('assets/business.json'),)
          ),
        );
        },
    );

  }

}


