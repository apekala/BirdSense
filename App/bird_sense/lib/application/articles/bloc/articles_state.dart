part of 'articles_bloc.dart';

@immutable
sealed class ArticlesState {}

final class ArticlesInitial extends ArticlesState {}

final class ArticlesLoaded extends ArticlesState {
   final List<ArticlesEntity>? articles;

  ArticlesLoaded({required this.articles});

}


final class ArticlesLoding extends ArticlesState {
  final List<ArticlesEntity>? lastArticles;

  ArticlesLoding({this.lastArticles});

}
