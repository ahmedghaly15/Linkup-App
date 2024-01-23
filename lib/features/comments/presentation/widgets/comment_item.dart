import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/features/comments/data/models/comment_model.dart';
import 'package:social_app/features/comments/presentation/widgets/comment_item_content.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        CachedNetworkImage(
          errorWidget: (context, error, _) => const CachedImageErrorIcon(),
          imageUrl: comment.image!,
          imageBuilder: (_, image) {
            return CircleAvatar(
              backgroundImage: image,
              radius: 20.r,
              backgroundColor: AppColors.primaryColor,
            );
          },
        ),
        Flexible(
          child: ChatBubble(
            clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
            margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
            backGroundColor: Helper.isDark(context)
                ? AppColors.darkPrimaryColor.withOpacity(0.9)
                : Colors.white,
            elevation: Helper.isDark(context) ? 5.h : 10.h,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 5.h,
                ),
                child: CommentItemContent(comment: comment),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
