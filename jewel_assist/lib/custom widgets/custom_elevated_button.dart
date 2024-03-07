import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jewel_assist/constants/color.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool? isIcon;
  final bool? isSuffixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? horizontalPadding;
  final Widget? child;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.fontSize,
    this.isIcon,
    this.isSuffixIcon,
    this.suffixIcon,
    this.horizontalPadding,
    this.borderColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 54,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ConstantColor.primaryColor,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          padding: horizontalPadding,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
              )),
        ),
        child: child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isSuffixIcon == true)
                  Row(
                    children: [
                      suffixIcon ??
                          const Icon(
                            Icons.add,
                            color: ConstantColor.white,
                          ),
                      10.horizontalSpace,
                    ],
                  ),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? ConstantColor.white,
                    fontSize: fontSize ?? 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
