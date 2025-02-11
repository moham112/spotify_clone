import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/repoistory/song/song.dart';
import 'package:spotify_clone/service_locator.dart';

class IsFavoriteSongUseCase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
}
