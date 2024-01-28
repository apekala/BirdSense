import 'package:bird_sense/application/articles/bloc/articles_bloc.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:bird_sense/data/model/colors.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArticlesPage extends HookWidget{
   const ArticlesPage({
    super.key, 
    });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesBloc,ArticlesState>(
      builder: (context, state) {
        if(state is ArticlesLoaded){
          return RefreshIndicator(
            onRefresh: () async{
              context.read<ArticlesBloc>().add(ArticlesCount());
            },
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.articles?.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {
                    // _launchUrl(Uri.parse(state.articles![index].articleURL));
                    launchUrlString(state.articles![index].articleURL);
                  },
                  child: Container(
                    height: 280,
                    width: 300,
                    // padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                    decoration: BoxDecoration(
                      color: WAColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // backgroundBlendMode: BlendMode.srcATop
                    ),
                    child: Center(
                      child: Column(
                        
                        
                        children: [
                        // Text(state.articles![index].articleURL,
                        // textAlign: TextAlign.center,
                        // style: const TextStyle(
                        //   fontSize: 12,
                        //   decoration: TextDecoration.underline
                        // ),),
                        const SizedBox(height: 10,),
                        Image.network(state.articles![index].imageURL,
                        width: double.infinity,
                        height: 200,
                        // cacheHeight: 150,
                        ),
                        const SizedBox(height: 10,),
                        Text(state.articles![index].header,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),)
                      ]),
                    ),
                  ),
                );
              }
              
              ),
          );

        }

        else{
          return const Center(child: CircularProgressIndicator(),);
        }


      }
      );
  }
  Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

}