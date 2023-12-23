import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/feeds/domain/repositories/feeds_repo.dart';

class UploadPostImageUseCase implements BaseUseCases<TaskSnapshot, File?> {
  final FeedsRepo feedsRepo;

  const UploadPostImageUseCase({required this.feedsRepo});

  @override
  Future<Either<Failure, TaskSnapshot>> call(File? params) async {
    return await feedsRepo.uploadPostImage(postImage: params);
  }
}
