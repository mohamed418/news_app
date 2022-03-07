// ignore_for_file: avoid_print

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit_A/cubit_A.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Top News'),
            actions: [
              IconButton(
                onPressed: (){
                  NewsCubitA.get(context).changeAppMode();
                },
                icon: const Icon(Icons.brightness_4_rounded, size: 30,),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: cubit.currentIndex,
          //   onTap: (index){
          //     cubit.changeBottomNav(index);
          //   },
          //   items: cubit.bottomItems,
          // ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.red.shade900,
                hoverColor: Colors.red.shade900,
                gap: 8,
                activeColor: Colors.red.shade900,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 500),
                tabBackgroundColor: Colors.grey.shade400,
                color: Colors.black,
                tabs: cubit.tabs,
                selectedIndex: cubit.currentIndex,
                onTabChange: (index) {
                  cubit.changeBottomNav(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
