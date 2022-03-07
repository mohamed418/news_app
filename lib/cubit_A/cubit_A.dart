// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit_A/states_A.dart';
import 'package:news_app/network/local/cache_helper.dart';

class NewsCubitA extends Cubit<NewsStatesA> {
  NewsCubitA() : super(NewsInitialStateA());

  static NewsCubitA get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if(fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppThemeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppThemeState());
      });
    }
  }
}
