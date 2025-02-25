import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/features/edit_profile/domain/entities/update_user_params.dart';
import 'package:social_app/features/edit_profile/domain/usecases/get_image.dart';
import 'package:social_app/features/edit_profile/domain/usecases/update_user.dart';
import 'package:social_app/features/edit_profile/domain/usecases/update_user_comments.dart';
import 'package:social_app/features/edit_profile/domain/usecases/update_user_in_other_users_followers.dart';
import 'package:social_app/features/edit_profile/domain/usecases/update_user_in_other_users_following.dart';
import 'package:social_app/features/edit_profile/domain/usecases/update_user_likes.dart';
import 'package:social_app/features/edit_profile/domain/usecases/update_user_posts.dart';
import 'package:social_app/features/edit_profile/domain/usecases/upload_image.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetImageUseCase getImageUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final UpdateUserPostsUseCase updateUserPostsUseCase;
  final UpdateUserLikesUseCase updateUserLikesUseCase;
  final UpdateUserCommentsUseCase updateUserCommentsUseCase;
  final UpdateUserInOtherUsersFollowersUseCase
      updateUserInOtherUsersFollowersUseCase;

  final UpdateUserInOtherUsersFollowingUseCase
      updateUserInOtherUsersFollowingUseCase;

  EditProfileCubit({
    required this.updateUserUseCase,
    required this.getImageUseCase,
    required this.uploadImageUseCase,
    required this.updateUserPostsUseCase,
    required this.updateUserLikesUseCase,
    required this.updateUserCommentsUseCase,
    required this.updateUserInOtherUsersFollowersUseCase,
    required this.updateUserInOtherUsersFollowingUseCase,
  }) : super(const EditProfileInitial());

  void updateUser({required UpdateUserParams params}) {
    emit(const UpdateUserLoading());

    updateUserUseCase(params).then((value) {
      value.fold(
        (failure) => emit(
          UpdateUserError(error: failure.failureMsg.toString()),
        ),
        (success) => emit(const UpdateUserSuccess()),
      );
    });
  }

  Future<void> updateUserPosts() async {
    updateUserPostsUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) => emit(
          UpdateUserPostsError(error: failure.failureMsg.toString()),
        ),
        (success) => emit(const UpdateUserPostsSuccess()),
      );
    });
  }

  Future<void> updateUserLikes() async {
    updateUserLikesUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) =>
            emit(UpdateUserLikesError(error: failure.failureMsg.toString())),
        (success) => emit(const UpdateUserLikesSuccess()),
      );
    });
  }

  Future<void> updateUserComments() async {
    updateUserCommentsUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) =>
            emit(UpdateUserCommentsError(error: failure.failureMsg.toString())),
        (success) => emit(const UpdateUserCommentsSuccess()),
      );
    });
  }

  Future<void> updateUserInOtherUsersFollowers() async {
    updateUserInOtherUsersFollowersUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) => emit(
          UpdateUserInOtherUsersFollowersError(
              error: failure.failureMsg.toString()),
        ),
        (success) => emit(const UpdateUserInOtherUsersFollowersSuccess()),
      );
    });
  }

  Future<void> updateUserInOtherUsersFollowing() async {
    updateUserInOtherUsersFollowingUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) => emit(
          UpdateUserInOtherUsersFollowingError(
            error: failure.failureMsg.toString(),
          ),
        ),
        (success) => emit(const UpdateUserInOtherUsersFollowingSuccess()),
      );
    });
  }

  File? profileImage;

  void getProfileImage({required ImageSource source}) {
    getImageUseCase(source).then((value) {
      value.fold(
        (failure) => emit(
          ImagePickedError(error: failure.failureMsg.toString()),
        ),
        (result) {
          if (result != null) {
            profileImage = File(result.path);
          }

          emit(ImagePickedSuccess(image: profileImage!));
        },
      );
    });
  }

  void uploadProfileImage({required UpdateUserParams params}) {
    emit(const UploadProfileImageLoading());

    uploadImageUseCase(profileImage).then((value) {
      value.fold(
        (failure) => emit(
          UploadImageError(error: failure.failureMsg.toString()),
        ),
        (result) {
          result.ref.getDownloadURL().then((value) {
            updateUser(
              params: UpdateUserParams(
                name: params.name,
                phone: params.phone,
                bio: params.bio,
                email: params.email,
                image: value,
                xUrl: params.xUrl,
                instagramUrl: params.instagramUrl,
                facebookUrl: params.facebookUrl,
                githubUrl: params.githubUrl,
              ),
            );

            emit(UploadImageSuccess(imageUrl: value));
          }).catchError((error) {
            emit(UploadImageError(error: error.toString()));
          });
        },
      );
    });
  }

  File? coverImage;

  void getCoverImage({required ImageSource source}) {
    getImageUseCase(source).then((value) {
      value.fold(
        (failure) => emit(
          ImagePickedError(error: failure.failureMsg.toString()),
        ),
        (result) {
          if (result != null) {
            coverImage = File(result.path);
          }

          emit(ImagePickedSuccess(image: coverImage!));
        },
      );
    });
  }

  void uploadCoverImage({required UpdateUserParams params}) {
    emit(const UploadCoverImageLoading());

    uploadImageUseCase(coverImage).then((value) {
      value.fold(
        (failure) => emit(
          UploadImageError(error: failure.failureMsg.toString()),
        ),
        (result) {
          result.ref.getDownloadURL().then((value) {
            updateUser(
              params: UpdateUserParams(
                name: params.name,
                phone: params.phone,
                bio: params.bio,
                email: params.email,
                cover: value,
              ),
            );

            emit(UploadImageSuccess(imageUrl: value));
          }).catchError((error) {
            emit(UploadImageError(error: error.toString()));
          });
        },
      );
    });
  }
}
