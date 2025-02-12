import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/posts/domain/entities/create_post_params.dart';
import 'package:social_app/features/posts/domain/usecases/create_post.dart';
import 'package:social_app/features/posts/domain/usecases/delete_post.dart';
import 'package:social_app/features/posts/domain/usecases/get_post_image.dart';
import 'package:social_app/features/posts/domain/usecases/like_post.dart';
import 'package:social_app/features/posts/domain/usecases/liked_posts_by_me.dart';
import 'package:social_app/features/people_who_liked/domain/usecases/people_who_liked.dart';
import 'package:social_app/features/posts/domain/usecases/unlike_post.dart';
import 'package:social_app/features/posts/domain/usecases/upload_post_image.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final GetPostImageUseCase getPostImageUseCase;
  final UploadPostImageUseCase uploadPostImageUseCase;
  final LikePostUseCase likePostUseCase;
  final UnLikePostUseCase unLikePostUseCase;
  final LikedPostsByMeUseCase likedPostsByMeUseCase;
  final PeopleWhoLikedUseCase peopleLikeThePostUseCase;

  PostsCubit({
    required this.createPostUseCase,
    required this.deletePostUseCase,
    required this.getPostImageUseCase,
    required this.uploadPostImageUseCase,
    required this.likePostUseCase,
    required this.unLikePostUseCase,
    required this.likedPostsByMeUseCase,
    required this.peopleLikeThePostUseCase,
  }) : super(const PostsInitial());

  void createPost({required CreatePostParams createPostParams}) {
    emit(const CreatePostLoading());

    createPostUseCase(createPostParams).then((value) {
      value.fold(
        (failure) =>
            emit(CreatePostError(error: failure.failureMsg.toString())),
        (success) {
          postImage = null;
          emit(const CreatePostSuccess());
        },
      );
    });
  }

  void deletePost({required String postId}) {
    emit(const DeletePostLoading());

    deletePostUseCase(postId).then((value) {
      value.fold(
        (failure) =>
            emit(DeletePostError(error: failure.failureMsg.toString())),
        (success) => emit(const DeletePostSuccess()),
      );
    });
  }

  File? postImage;

  void getPostImage({required ImageSource source}) {
    getPostImageUseCase(source).then((value) {
      value.fold(
        (failure) =>
            emit(PostImagePickedError(error: failure.failureMsg.toString())),
        (result) {
          if (result != null) {
            postImage = File(result.path);

            emit(PostImagePickedSuccess(postImage: postImage!));
          }
        },
      );
    });
  }

  void uploadPostImage({
    required CreatePostParams createPostParams,
  }) {
    emit(const UploadPostImageLoading());

    uploadPostImageUseCase(postImage).then((value) {
      value.fold(
        (failure) =>
            emit(UploadPostImageError(error: failure.failureMsg.toString())),
        (result) {
          result.ref.getDownloadURL().then((value) {
            createPost(
              createPostParams: CreatePostParams(
                date: createPostParams.date,
                time: createPostParams.time,
                text: createPostParams.text,
                postImage: value,
              ),
            );
            postImage = null;
            emit(UploadPostImageSuccess(imageUrl: value));
          }).catchError((error) {
            emit(UploadPostImageError(error: error.toString()));
          });
        },
      );
    });
  }

  void removePostImage() {
    postImage = null;
    emit(const PostImageRemoved());
  }

  void likePost({required String postId}) {
    likePostUseCase(postId).then(
      (value) {
        value.fold(
          (failure) =>
              emit(LikePostError(error: failure.failureMsg.toString())),
          (success) => emit(const LikePostSuccess()),
        );
      },
    );
  }

  void unLikePost({required String postId}) {
    unLikePostUseCase(postId).then((value) {
      value.fold(
        (failure) =>
            emit(UnLikePostError(error: failure.failureMsg.toString())),
        (success) => emit(const UnLikePostSuccess()),
      );
    });
  }

  Stream<bool> likedPostsByMe({required String postId}) =>
      likedPostsByMeUseCase(postId);
}
