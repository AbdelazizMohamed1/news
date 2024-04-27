
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_layout/cubit/states.dart';
import 'package:news/modules/news_app/search/search_screen.dart';

import 'cubit/cubit.dart';


class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: cubit.appbarTitle[cubit.index],
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                },
                icon: Icon(
                  Icons.search
                ),),
              IconButton(
                onPressed: () {
                  cubit.changeAppMode();
                },
                icon: Icon(
                    Icons.brightness_4_outlined
                ),),
            ],),
          body: cubit.screens[cubit.index],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.index,
            onTap: (value) {
              cubit.changeBottomNav(value);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business_sharp), label: 'business'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports), label: 'sports'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science), label: 'science'),
            ],
          ),
        );
      },
    );
  }
}
