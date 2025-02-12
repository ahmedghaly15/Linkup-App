import 'package:dartz/dartz.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/following_and_followers/domain/repositories/following_and_followers_repo.dart';

class GetFollowingUseCase implements BaseUseCases<List<UserModel>, NoParams> {
  final FollowingAndFollowersRepo followingAndFollowersDataRepo;

  const GetFollowingUseCase({
    required this.followingAndFollowersDataRepo,
  });

  @override
  Future<Either<Failure, List<UserModel>>> call(
    NoParams params,
  ) async {
    return await followingAndFollowersDataRepo.getFollowing();
  }
}
