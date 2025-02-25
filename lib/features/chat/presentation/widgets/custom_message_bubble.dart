import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/date_and_time.dart';
import 'package:social_app/features/chat/data/models/message_model.dart';

class CustomMessageBubble extends StatelessWidget {
  const CustomMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  final MessageModel message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: isMe
          ? ChatBubbleClipper3(type: BubbleType.sendBubble)
          : ChatBubbleClipper3(type: BubbleType.receiverBubble),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      backGroundColor: isMe
          ? AppColors.primaryColor
          : (Helper.isDark(context) ? AppColors.darkHeaderClr : Colors.white),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.65,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (message.messageText != null) ...[
              Text(
                message.messageText!,
                style: AppTextStyles.textStyle16SemiBold.copyWith(
                  color: isMe
                      ? Colors.white
                      : (Helper.isDark(context) ? Colors.white : Colors.black),
                ),
                maxLines: null,
              ),
            ],
            if (message.messageText != null && message.messageImage != null)
              SizedBox(height: 8.h),
            if (message.messageImage!['image'] != null)
              Container(
                width: double.infinity,
                height: 220.h,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.r),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(
                      message.messageImage!['image'],
                    ),
                  ),
                ),
              ),
            SizedBox(height: 6.h),
            DateAndTime(
              date: message.date!,
              time: message.time!,
            ),
          ],
        ),
      ),
    );
  }
}
