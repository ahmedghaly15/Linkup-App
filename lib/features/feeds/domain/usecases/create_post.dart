import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/feeds/domain/repositories/feeds_repo.dart';

class CreatePostUseCase
    implements
        BaseUseCases<DocumentReference<Map<String, dynamic>>, PostModel> {
  final FeedsRepo feedsRepo;

  const CreatePostUseCase({required this.feedsRepo});

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> call(
    PostModel params,
  ) async {
    return await feedsRepo.createPost(post: params);
  }
}
