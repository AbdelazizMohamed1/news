import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_layout/cubit/cubit.dart';
import 'package:news/layout/news_layout/cubit/states.dart';
import 'package:news/layout/news_layout/news_layout.dart';
import 'package:news/layout/news_layout/key_screen.dart';
import 'package:news/shared/bloc_observier.dart';
import 'package:news/shared/components/constants.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'package:news/shared/styles/styles.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();
  if(CacheHelper.getData('isDark') != null){
    isDark = CacheHelper.getData('isDark');
  }
  if(CacheHelper.getData('keyIsOk') != null){
    keyIsOk = CacheHelper.getData('keyIsOk');
  }
  if(CacheHelper.getData('newsKey') != null){
    newsKey = CacheHelper.getData('newsKey');
  }

  if(newsKey != null){
     print('key is  not null');
     print(newsKey);

  }else{
    print('key is null');
    print(newsKey);
  }
  print(keyIsOk);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..checkKey(newsKey!),)
      ],
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            home: keyIsOk ?  const NewsLayout() : KeyScreen(),
          );
        },

      ),
    );
  }
}


