sealed class FavoriteButtonState {}

class FavoriteButtonInitial extends FavoriteButtonState {} // initial state

class FavoriteButtonUpdated extends FavoriteButtonState {
  final bool isFavorite;

  FavoriteButtonUpdated({required this.isFavorite});
} // loading state
