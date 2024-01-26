// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bird_sense/application/articles/articles_entity.dart';
import 'package:bird_sense/data/birds/atricles_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesRepository repository;
  ArticlesBloc({
    required this.repository,
  }) : super(ArticlesInitial()) {
    on<ArticlesCount>((event, emit) async{
      
      final state = this.state;

      if (state is ArticlesLoaded) {
        emit(ArticlesLoding(lastArticles: state.articles));
      } else {
        emit(ArticlesLoding());
      }

      final articles = await repository.getArticles();
      
      if (articles != null){
        
        final articlesEntity = articles.map((e) =>  ArticlesEntity.fromModel(e)).toList();
        emit(ArticlesLoaded(articles: articlesEntity));
      }
      else{
        emit(ArticlesInitial());
      }

    });
  }
}
