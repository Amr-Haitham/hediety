import 'package:flutter/cupertino.dart';

import '../../../../core/config/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/buttons/text_button_widget.dart';

class SignUpInsteadButton extends StatelessWidget {
  const SignUpInsteadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppTextStyles.bodySmallTextStyle16
              .copyWith(fontWeight: FontWeight.w500),
        ),
        TextButtonWidget(
            text: "Create account",
            textStyle: AppTextStyles.bodySmallTextStyle16
                .copyWith(fontWeight: FontWeight.w700),
            textColors: AppColors.textPrimaryColor,
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.signUpRoute);
            }),
      ],
    );
  }
}
