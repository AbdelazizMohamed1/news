import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_layout/cubit/cubit.dart';
import 'package:news/layout/news_layout/cubit/states.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/network/local/cache_helper.dart';


class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                    
                  defaultTextFormField(
                      controller: searchController,
                      textInputType: TextInputType.text,
                    //  hintText: 'search',
                      labelText: 'search',
                      validate: (value) {
                        if(value!.isEmpty){
                          'Search must not be empty';
                        }
                      },
                      onSubmit: (value) {
                        NewsCubit.get(context).searchData(word: value,apiKey: CacheHelper.getData('newsKey'));
                      },

                  ),

                  Expanded(
                    child: ConditionalBuilder(
                      condition: true,
                      builder: (context) => ListView.separated(
                        itemBuilder: (context, index) => buildArticleItem(
                            NewsCubit.get(context).search[index], context),
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            thickness: 1.0,
                          ),
                        ),
                        itemCount: NewsCubit.get(context).search.length,
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
