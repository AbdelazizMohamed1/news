import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_layout/cubit/cubit.dart';
import 'package:news/layout/news_layout/cubit/states.dart';
import 'package:news/shared/components/components.dart';


class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: NewsCubit.get(context).science.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildArticleItem(NewsCubit.get(context).science[index],context),
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(

                thickness: 1.0,
              ),
            ),
            itemCount: NewsCubit.get(context).science.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
