import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              thickness: 1,
              color: AppColors.lightGrey,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Or",
            style: AppTextStyles.bodyMediumTextStyle20
                .copyWith(color: AppColors.textSecondaryColor),
          ),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: Divider(
              thickness: 1,
              color: AppColors.lightGrey,
            ),
          ),
        ],
      ),
    );
  }
}
