import 'package:spotify_clone/domain/entities/song/song.dart';

sealed class NewsSongsState {}

class NewsSongsLoading extends NewsSongsState {}

class NewsSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs;

  NewsSongsLoaded({required this.songs});
}

class NewsSongsLoadFailure extends NewsSongsState {}
