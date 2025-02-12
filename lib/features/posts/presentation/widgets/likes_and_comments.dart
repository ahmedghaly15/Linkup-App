import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/features/comments/domain/entities/comments_view_params.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/service_locator.dart';

class LikesAndComments extends StatelessWidget {
  const LikesAndComments({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        final PostsCubit cubit = BlocProvider.of<PostsCubit>(context);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                StreamBuilder<bool>(
                  stream: post.postId != null
                      ? cubit.likedPostsByMe(postId: post.postId!)
                      : const Stream<bool>.empty(),
                  builder: (context, snapshot) {
                    bool isPostLikedByMe = snapshot.data ?? false;

                    return IconButton(
                      onPressed: () {
                        isPostLikedByMe
                            ? cubit.unLikePost(postId: post.postId!)
                            : cubit.likePost(postId: post.postId!);
                      },
                      icon: isPostLikedByMe
                          ? Image.asset(AppAssets.iconsRedLike)
                          : Image.asset(
                              Helper.isDark(context)
                                  ? AppAssets.iconsGreyLike
                                  : AppAssets.iconsLike,
                            ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    context.navigateTo(
                      routeName: Routes.peopleWhoLiked,
                      arguments: post.postId,
                    );
                  },
                  child: StreamBuilder(
                    stream: _likesStream(),
                    builder: (context, snapshot) {
                      int likesCount = snapshot.data?.docs.length ?? 0;

                      return Text(
                        "$likesCount Likes",
                        style: AppTextStyles.textStyle15.copyWith(
                          color: Helper.isDark(context)
                              ? Colors.white54
                              : AppColors.lightGrey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () {
                context.navigateTo(
                  routeName: Routes.commentsRoute,
                  arguments: CommentsViewParams(
                    postId: post.postId,
                    postUserId: post.user!.uId,
                  ),
                );
              },
              icon: Image.asset(
                Helper.isDark(context)
                    ? AppAssets.iconsGreyComment
                    : AppAssets.iconsComment,
              ),
              label: StreamBuilder(
                  stream: _commentsStream(),
                  builder: (context, snapshot) {
                    int commentsCount = snapshot.data?.docs.length ?? 0;

                    return Text(
                      "$commentsCount comments",
                      style: AppTextStyles.textStyle13.copyWith(
                        color: Helper.isDark(context)
                            ? Colors.white54
                            : AppColors.lightGrey,
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _commentsStream() {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(post.postId)
        .collection(AppStrings.comments)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _likesStream() {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(post.postId)
        .collection(AppStrings.likes)
        .snapshots();
  }
}
