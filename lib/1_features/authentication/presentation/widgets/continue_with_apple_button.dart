import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_constants/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/buttons/button_widget.dart';

class ContinueWithAppleButton extends StatelessWidget {
  const ContinueWithAppleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onPressed: () {
        signInWithApple();
      },
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: AppColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.appleLogo,
            color: AppColors.primaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Continue with Apple",
            style: AppTextStyles.bodyMediumTextStyle20
                .copyWith(color: AppColors.textSecondaryColor),
          ),
        ],
      ),
    );
  }

  void signInWithApple() {
    //ToDo: Raslan, integrate with SignInWithApple API
  }
}
