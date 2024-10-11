import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_quote_generator/global/themes/app_theme.dart';
import 'loading_spinner.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.isDisabled = false,
    this.isLoading = false,
    this.loadingSpinnerKey,
  });

  final IconData icon;
  final Function()? onPressed;
  final Color? color;
  final bool isDisabled;
  final bool isLoading;
  final Key? loadingSpinnerKey;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Padding(
            padding: EdgeInsets.all(8.r),
            child: LoadingSpinner(
              key: loadingSpinnerKey,
              size: 22.r,
              strokeWidth: 2,
            ),
          )
        : IconButton(
            iconSize: 22.r,
            padding: EdgeInsets.all(8.r),
            constraints: const BoxConstraints(),
            disabledColor: context.theme.color.onBackground.withOpacity(0.3),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: FaIcon(
              icon,
              color: color ?? context.theme.color.onBackground,
            ),
            onPressed: isDisabled ? null : onPressed,
          );
  }
}
