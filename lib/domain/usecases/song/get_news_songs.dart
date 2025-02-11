import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/repoistory/song/song.dart';
import 'package:spotify_clone/service_locator.dart';

class GetNewsSongsUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getNewsSongs();
  }
}
