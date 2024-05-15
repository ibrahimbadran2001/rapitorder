import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/home_layout/cubit.dart';
import 'package:proj1/layout/home_layout/states.dart';
import 'package:proj1/layout/login/login_screen.dart';
import 'package:proj1/modules/home/home_cubit.dart';
import 'package:proj1/modules/home/home_screen.dart';
import 'package:proj1/modules/on_boarding/onBoarding_screen.dart';
import 'package:proj1/modules/orders/orders_screen.dart';
import 'package:proj1/modules/restaurant/restaurants_cubit.dart';
import 'package:proj1/modules/splash/splash_screen.dart';
import 'package:proj1/shared/network/local/cache_helper.dart';
import 'package:proj1/shared/network/remote/dio_helper.dart';
import 'package:proj1/shared/style/themes.dart';
import 'layout/home_layout/home_layout.dart';
import 'modules/favorite/favorite_cubit.dart';
import 'observer.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool ? isDark=CacheHelper.getData(key: 'isDark');
  Widget widget;
  String ? token=CacheHelper.getData(key: 'token');
  bool? onBoarding=CacheHelper.getData(key: 'onBoarding');
  if(onBoarding!=null&&onBoarding){
    print("onBoarding");
    print(onBoarding);
    print('token:$token');
    if(token!=null){
      widget=HomeLayout();
    }else{
      widget=LoginScreen();
    }
  }else{
    widget=SplashScreen();
  }
  runApp(
      MyApp(
        isDark??false,
        widget,
      ),
  );
}
class MyApp extends StatelessWidget {
    final bool isDark;
    final Widget startWidget;
   MyApp(this.isDark,this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) {
          return AppCubit()..changeAppMode(fromShared: isDark);
        },),
        BlocProvider(create: (context){return RestaurantCubit()..getFood()..getFromSp();}),
        BlocProvider(create: (context) => FavoriteCubit(),),
        BlocProvider(create: (context) => HomeCubit()..getBanners()..getCategories()..getFoodByCategory(1)..getRestaurants(),),
        BlocProvider(create: (context) => RestaurantCubit()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, state){
          return MaterialApp(
            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
