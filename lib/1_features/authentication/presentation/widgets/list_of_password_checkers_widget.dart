import 'package:flutter/cupertino.dart';

import '../../auth_utility_functions/auth_input_validator.dart';
import '../../domain/entities/password_checker.dart';
import 'password_checker_widget.dart';

class ListOfPasswordCheckersWidget extends StatefulWidget {
  final String password;
  final bool submitButtonPressed;
  List<PasswordChecker> passwordCheckers;
  ListOfPasswordCheckersWidget(
      {super.key,
      required this.password,
      required this.submitButtonPressed,
      required this.passwordCheckers});

  @override
  State<ListOfPasswordCheckersWidget> createState() =>
      _ListOfPasswordCheckersWidgetState();
}

class _ListOfPasswordCheckersWidgetState
    extends State<ListOfPasswordCheckersWidget> {
  @override
  void initState() {
    super.initState();
    AuthInputValidator.validatePassword(widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.passwordCheckers
            .map((passwordChecker) => PasswordCheckerWidget(
                  submitButtonPressed: widget.submitButtonPressed,
                  passwordChecker: passwordChecker,
                  passwordCheckerIndex:
                      widget.passwordCheckers.indexOf(passwordChecker),
                )),
      ],
    );
  }

  @override
  void didUpdateWidget(ListOfPasswordCheckersWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.password != widget.password) {
      AuthInputValidator.validatePassword(widget.password);
    }
  }
}
