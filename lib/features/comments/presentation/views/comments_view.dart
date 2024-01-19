import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:social_app/features/comments/domain/entities/comments_view_params.dart';
import 'package:social_app/features/comments/presentation/cubit/comments_cubit.dart';
import 'package:social_app/features/comments/presentation/widgets/comment_item.dart';
import 'package:social_app/features/comments/presentation/widgets/commenter_field.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({
    super.key,
    required this.params,
  });

  final CommentsViewParams params;

  @override
  Widget build(BuildContext context) {
    print('POST ID: ${params.postId}');

    return Scaffold(
      body: CustomFillingContainer(
        child: CustomContentContainer(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 75.h),
                child: CustomScrollView(
                  slivers: [
                    CustomSliverAppBar(
                      title: 'Comments',
                      backOnPressed: () {
                        BlocProvider.of<CommentsCubit>(context).clearComments();

                        context.back();
                      },
                    ),
                    BlocBuilder<CommentsCubit, CommentsState>(
                      builder: (context, state) {
                        final cubit = BlocProvider.of<CommentsCubit>(context);
                        return cubit.comments.isNotEmpty
                            ? SliverPadding(
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                  top: 16.h,
                                ),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return CommentItem(
                                        comment: cubit.comments[index],
                                      );
                                    },
                                    childCount: cubit.comments.length,
                                  ),
                                ),
                              )
                            : const SliverFillRemaining(child: SizedBox());
                      },
                    ),
                  ],
                ),
              ),
              CommenterField(postId: params.postId!),
            ],
          ),
        ),
      ),
    );
  }
}
