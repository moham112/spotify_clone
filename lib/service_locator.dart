import 'package:get_it/get_it.dart';
import 'package:spotify_clone/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_clone/data/repository/songs/song_repoisotry_impl.dart';
import 'package:spotify_clone/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_clone/data/sources/songs/song_firebase_service.dart';
import 'package:spotify_clone/domain/repoistory/auth/auth.dart';
import 'package:spotify_clone/domain/repoistory/song/song.dart';
import 'package:spotify_clone/domain/usecases/auth/get_user.dart';
import 'package:spotify_clone/domain/usecases/auth/signin.dart';
import 'package:spotify_clone/domain/usecases/auth/signup.dart';
import 'package:spotify_clone/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify_clone/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotify_clone/domain/usecases/song/get_news_songs.dart';
import 'package:spotify_clone/domain/usecases/song/get_play_list.dart';
import 'package:spotify_clone/domain/usecases/song/is_favorite_song.dart';

final sl = GetIt.instance;

Future<void> initilizeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthenFirebaseServiceImpl(),
  );
  sl.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl(),
  );
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );
  sl.registerSingleton<SongsRepository>(
    SongRepoisotryImpl(),
  );
  sl.registerSingleton<SignupUseCase>(
    SignupUseCase(),
  );
  sl.registerSingleton<SigninUseCase>(
    SigninUseCase(),
  );
  sl.registerSingleton<GetNewsSongsUseCase>(
    GetNewsSongsUseCase(),
  );
  sl.registerSingleton<GetPlayListUseCase>(
    GetPlayListUseCase(),
  );
  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
    AddOrRemoveFavoriteSongUseCase(),
  );
  sl.registerSingleton<IsFavoriteSongUseCase>(
    IsFavoriteSongUseCase(),
  );
  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase(),
  );
  sl.registerSingleton<GetFavoriteSongsUseCase>(
    GetFavoriteSongsUseCase(),
  );
}
