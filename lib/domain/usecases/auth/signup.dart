import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';
import 'package:spotify_clone/domain/repoistory/auth/auth.dart';
import 'package:spotify_clone/service_locator.dart';

class SignupUseCase implements Usecase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) async{
    return sl.get<AuthRepository>().signup(params!);
  }

}