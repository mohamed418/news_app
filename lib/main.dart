import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/network/local/bloc_observer.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/news_app/news_layout.dart';
import 'cubit_A/cubit_A.dart';
import 'cubit_A/states_A.dart';
import 'news_app/cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBool(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(create: (BuildContext context) => NewsCubitA()..changeAppMode(fromShared: isDark),),
      ],
      child: BlocProvider(
        create: (BuildContext context) => NewsCubitA()..changeAppMode(
            fromShared: isDark),
        child: BlocConsumer<NewsCubitA, NewsStatesA>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.red,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                    // systemOverlayStyle: SystemUiOverlayStyle(
                    //   statusBarColor: Colors.red,
                    //   statusBarIconBrightness: Brightness.light
                    // ),
                      titleTextStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                      titleSpacing: 20,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      iconTheme: IconThemeData(
                          color: Colors.black
                      )
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.red,
                      backgroundColor: Colors.white,
                      unselectedItemColor: Colors.grey,
                      elevation: 20
                  ),
                  textTheme: const TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      )
                  )
              ),
              darkTheme: ThemeData(
                  primarySwatch: Colors.red,
                  scaffoldBackgroundColor: HexColor('333639'),
                  appBarTheme: AppBarTheme(
                      titleTextStyle: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                      titleSpacing: 20,
                      backgroundColor: HexColor('333639'),
                      elevation: 0,
                      iconTheme: const IconThemeData(
                          color: Colors.white
                      )
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.red,
                      backgroundColor: HexColor('333639'),
                      unselectedItemColor: Colors.grey,
                      elevation: 20
                  ),
                  textTheme: const TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      )
                  )
              ),
              themeMode: NewsCubitA.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: const Directionality(textDirection: TextDirection.rtl, child: NewsLayout()),
            );
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Center(),
    );
  }
}
