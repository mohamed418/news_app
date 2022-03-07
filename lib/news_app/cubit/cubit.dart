// ignore_for_file: avoid_print

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_app/modules/business/business_Screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/news_app/cubit/states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<GButton> tabs = [
    GButton(icon: LineIcons.businessTime, text: 'Business'),
    GButton(icon: LineIcons.footballBall, text: 'Sports'),
    GButton(icon: LineIcons.school, text: 'Science'),
    GButton(icon: LineIcons.search, text: 'Search'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SearchScreen(),
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsChangeBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(GetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '4c942b69a7d94b92817fb921602ca03a',
      },
    ).then((value) {
      emit(GetBusinessSuccessState());
      business = value.data['articles'];
    }).catchError((error) {
      emit(GetBusinessErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(GetSportsLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '4c942b69a7d94b92817fb921602ca03a',
        },
      ).then((value) {
        emit(GetSportsSuccessState());
        sports = value.data['articles'];
      }).catchError((error) {
        emit(GetSportsErrorState(error.toString()));
        print(error.toString());
      });
    }else{
      emit(GetSportsSuccessState());
    }

  }

  List<dynamic> science = [];

  void getScience() {
    emit(GetScienceLoadingState());
    if(science.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '4c942b69a7d94b92817fb921602ca03a',
        },
      ).then((value) {
        emit(GetScienceSuccessState());
        science = value.data['articles'];
      }).catchError((error) {
        emit(GetScienceErrorState(error.toString()));
        print(error.toString());
      });
    }else{
      emit(GetScienceSuccessState());
    }

  }

  List<dynamic> search = [];

  void getSearch(String word) {
    emit(GetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': word,
        'apiKey': '4c942b69a7d94b92817fb921602ca03a',
      },
    ).then((value) {
      emit(GetSearchSuccessState());
      search = value.data['articles'];
    }).catchError((error) {
      emit(GetSearchErrorState(error.toString()));
      print(error.toString());
    });

  }

  void changeSearchBar() {
    search = [];
    emit(NewsChangeSearchBarState());
  }
}