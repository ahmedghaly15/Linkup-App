import 'package:flutter/material.dart';

import '../../../core/global/app_colors.dart';
import '../../cubit/cubit.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({Key? key, required this.cubit}) : super(key: key);

  final SocialAppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          autofocus: true,
          enableSuggestions: true,
          keyboardType: TextInputType.name,
          cursorColor: Colors.grey,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "Name...",
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
              letterSpacing: 0.5,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onChanged: (value) {
            cubit.searchList.clear();
            for (var user in cubit.users) {
              if (user.name!.toLowerCase().contains(value.toLowerCase())) {
                cubit.searchList.add(user);
                cubit.rebuildSearchList(cubit.searchList);
              }
            }
          },
        ),
      ),
    );
  }
}
