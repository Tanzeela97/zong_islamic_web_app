part of 'list_category_cubit.dart';

@immutable
abstract class ListCategoryState {}

class InitialListCategoryState extends ListCategoryState {
  InitialListCategoryState();
}

class ListCategoryLoadingState extends ListCategoryState {
  final bool? isVisible;

  ListCategoryLoadingState({this.isVisible});
}

// ignore: must_be_immutable
class ListCategorySuccessState extends ListCategoryState {
  List<CateInfo>? cateInfo;

  ListCategorySuccessState({this.cateInfo});
}

class ListCategoryErrorState extends ListCategoryState {
  final String? message;

  ListCategoryErrorState({this.message});
}

class FourCategoryLoadingState extends ListCategoryState {
  final bool? isVisible;

  FourCategoryLoadingState({this.isVisible});
}

// ignore: must_be_immutable
class FourCategorySuccessState extends ListCategoryState {
  List<News>? cateInfo;

  FourCategorySuccessState({this.cateInfo});
}

class FourCategoryErrorState extends ListCategoryState {
  final String? message;

  FourCategoryErrorState({this.message});
}