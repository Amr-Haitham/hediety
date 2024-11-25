import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../auth_utility_functions/password_checkers.dart';
import '../../domain/entities/password_checker.dart';

class PasswordCheckerWidget extends StatefulWidget {
  int passwordCheckerIndex;
  PasswordChecker passwordChecker;
  bool submitButtonPressed;

  PasswordCheckerWidget(
      {super.key,
      required this.submitButtonPressed,
      required this.passwordChecker,
      required this.passwordCheckerIndex});

  @override
  State<PasswordCheckerWidget> createState() => _PasswordCheckerWidgetState();
}

class _PasswordCheckerWidgetState extends State<PasswordCheckerWidget> {
  final Color fulfilledColor = AppColors.confirmationGreen;
  final Color notFulfilledColor = AppColors.grey;
  final Color errorColor = AppColors.red;
  late Color currentColor;

  @override
  void initState() {
    if (widget.submitButtonPressed) {
      if (passwordCheckers[widget.passwordCheckerIndex].status ==
          PasswordCheckerStatus.fulfilled) {
        currentColor = fulfilledColor;
      } else {
        currentColor = errorColor;
        widget.passwordChecker.status = PasswordCheckerStatus.error;
      }
    } else {
      currentColor = passwordCheckers[widget.passwordCheckerIndex].status ==
              PasswordCheckerStatus.fulfilled
          ? fulfilledColor
          : notFulfilledColor;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.submitButtonPressed) {
      if (passwordCheckers[widget.passwordCheckerIndex].status ==
          PasswordCheckerStatus.fulfilled) {
        currentColor = fulfilledColor;
      } else {
        currentColor = errorColor;
        widget.passwordChecker.status = PasswordCheckerStatus.error;
      }
    } else {
      currentColor = passwordCheckers[widget.passwordCheckerIndex].status ==
              PasswordCheckerStatus.fulfilled
          ? fulfilledColor
          : notFulfilledColor;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Icon(
          Icons.check_circle,
          color: currentColor,
          size: 14,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          passwordCheckers[widget.passwordCheckerIndex].label,
          style: TextStyle(color: currentColor),
        ),
      ]),
    );
  }
}
