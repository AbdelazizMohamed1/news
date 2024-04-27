import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_layout/cubit/states.dart';
import 'package:news/modules/news_app/business/business_screen.dart';
import 'package:news/modules/news_app/science/science_screen.dart';
import 'package:news/modules/news_app/sports/sports_screen.dart';
import 'package:news/shared/components/constants.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates> {

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int index = 0;

  List screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List appbarTitle = [
    const Text('Business News'),
    const Text('Sports News'),
    const Text('Science News'),
  ];

  List<dynamic> business = [];

  List<dynamic> sports = [];

  List<dynamic> science = [];

  List<dynamic> search = [];

  void changeBottomNav(int index) {
    this.index = index;
    emit(NewsBottomNavState());
  }


  void getBusiness(String apiKey) {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': apiKey
      },).then((value) {
      business = value.data['articles'];
      print('helllllo ${value.statusCode}');
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState());
    });
  }


  void getSports(String apiKey) {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'sports',
        'apiKey': apiKey
      },).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState());
    });
  }


  void getScience(String apiKey) {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'science',
        'apiKey': apiKey
      },).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState());
    });
  }


  void changeAppMode(){
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark);
      emit(NewsChangeAppModeState());
  }


  void searchData({
    required String word,
    controller,
    required String apiKey
}){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        path: 'v2/everything',
        query: {
          'q': word,
          'apiKey': apiKey
        }).then((value) {
          search = value.data['articles'];
          emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState());
    });
  }


   void checkKey(String key){
    emit( NewsCheckKeyLoadingState());
    DioHelper.getData(
        path: 'v2/top-headlines',
      query: {
        'country':'us',
        'apiKey': key
      }).then((value) {
        print('key is ok ');
        keyIsOk = true;
        CacheHelper.saveData(key: 'keyIsOk', value: true);
        CacheHelper.saveData(key: 'newsKey', value: key);
        getBusiness(key);
        getSports(key);
        getScience(key);
        emit( NewsCheckKeySuccessState());
    }).catchError((error){
      keyIsOk = false;
      CacheHelper.saveData(key: 'keyIsOk', value: false);
      print(error.toString());
      emit( NewsCheckKeyErrorState());
    });
  }
}