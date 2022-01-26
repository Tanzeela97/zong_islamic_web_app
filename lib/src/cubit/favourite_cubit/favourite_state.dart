part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {
  const FavouriteState();
}

class FavouriteInitial extends FavouriteState {
  const FavouriteInitial();
}
class FavouriteLoading extends FavouriteState {
  const FavouriteLoading();
}
class FavouriteLoaded extends FavouriteState {
  final List<A> favoriteList;
  const FavouriteLoaded({required this.favoriteList});
}
class FavouriteError extends FavouriteState {
  final String message;
  const FavouriteError({required this.message});
}
