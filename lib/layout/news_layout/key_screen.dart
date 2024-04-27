import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_layout/cubit/cubit.dart';
import 'package:news/layout/news_layout/cubit/states.dart';
import 'package:news/shared/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

class KeyScreen extends StatelessWidget {
  var keyController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  static String newsKey = '';
  final Uri url = Uri.parse('https://newsapi.org/');
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {
        if(state is NewsCheckKeyErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Row(
              children: [
                Icon(Icons.dangerous,color: Colors.white,),
                SizedBox(width: 10.0,),
                Text('Wrong Key Try again'),
              ],
            ),backgroundColor: Colors.red,)
          );

        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Welcome To News'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(

                    children: [
                      const Text('If you new or your key is expired go here and get one then put it..',
                          style: TextStyle(
                              fontSize: 25
                          )
                      ),
                      const SizedBox(height: 40.0,),
                      InkWell(
                        onTap: () async{
                          if(!await launchUrl(url)){
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: const Text('https://newsapi.org/',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w900,
                              fontSize: 40
                          ) ,),
                      ),
                      const SizedBox(height: 40.0,),
                      const Text('put your own key here:'),
                      const SizedBox(height: 40.0,),
                      defaultTextFormField(
                        validate: (value) {
                          if(value!.isEmpty){
                            return 'Please Enter Your Key';
                          }
                        },
                        controller: keyController,
                        textInputType: TextInputType.text,
                        hintText: 'Your Key',
                        onChange: (value) {
                          newsKey = value;
                          print(newsKey);
                        },
                      ),
                      const SizedBox(height: 40.0,),
                      ConditionalBuilder(
                        builder: (context) {
                          return defaultMaterialButton(
                              width: MediaQuery.of(context).size.width / 2 ,
                              onPressed: () {

                                print(newsKey);
                                if(formKey.currentState!.validate()){

                                  if(newsKey != '') {
                                    NewsCubit.get(context).checkKey(newsKey);
                                  }else{
                                    print('error');
                                  }
                                }

                              },
                              text: 'Submit'
                          );
                        },
                        fallback: (context) {
                          return const CircularProgressIndicator();
                        },
                        condition: state is! NewsCheckKeyLoadingState,

                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
