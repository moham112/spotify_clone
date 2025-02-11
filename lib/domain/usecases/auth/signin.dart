import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';
import 'package:spotify_clone/domain/repoistory/auth/auth.dart';
import 'package:spotify_clone/service_locator.dart';

class SigninUseCase implements Usecase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) async {
    return sl.get<AuthRepository>().signin(params!);
  }
}