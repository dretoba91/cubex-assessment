import 'package:cubex_assessment/helpers/size_calculator.dart';
import 'package:flutter/material.dart';

class AuthenticationHeader extends StatelessWidget {
  const AuthenticationHeader({
    super.key,
    this.backButtonFn,
    required this.titleText,
  });
  final Function? backButtonFn;
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: sizer(false, 10, context),
        ),
        Text(
          titleText,
          style: TextStyle(
            height: sizer(true, 1.4, context),
            fontSize: sizer(true, 28, context),
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        )
      ],
    );
  }
}
