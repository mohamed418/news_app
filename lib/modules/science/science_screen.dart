import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/models/component.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/cubit/states.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).science;
        return BuildCondition(
          condition: list.isNotEmpty,
          builder: (context) => AnimationLimiter(
            child: ListView.separated(
              key: const PageStorageKey<String>('SciencePage'),
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
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 400),
                  child: SlideAnimation(
                    verticalOffset: 150.0,
                    child: ScaleAnimation(
                      child: buildRow(list[index], context),
                    ),
                  ),
                );
              },
            ),
          ),
          fallback: (context) => Center(
              child: Center(
            child: Lottie.asset('assets/science.json'),
          )),
        );
      },
    );
  }
}
//flutter_staggered_animations
// return AnimationConfiguration.staggeredList(
//   position: index,
//   duration: const Duration(milliseconds: 375),
//   child: SlideAnimation(
//   verticalOffset: 50.0,
//   child: FadeInAnimation(
//   child: YourListChild(),
//   ),
// ),
