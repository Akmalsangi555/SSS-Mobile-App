
import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';

class SSSFilledButton extends StatelessWidget {
  const SSSFilledButton({
    super.key,
    this.child,
    required this.buttonText,
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.isLoading = false,
    this.loadingWidget,
    this.buttonWidth,
    this.buttonHeight = 47,
    this.borderRadius = 16.0,
  });

  final Widget? child;
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? textColor;
  final bool isLoading;
  final Widget? loadingWidget;
  final double buttonHeight;
  final double? buttonWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveBgColor = bgColor ?? AppTheme.backgroundColor;
    final effectiveTextColor = textColor ?? Colors.white;

    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      // Optional: you can add some basic visual feedback
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: buttonHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isLoading ?
          effectiveBgColor.withValues(alpha: 0.75) : effectiveBgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: isLoading ?
          null : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 8, offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? (loadingWidget ??
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.8,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ))
              : child ??
              Text(buttonText,
                style: TextStyle(
                  color: effectiveTextColor, fontSize: 16,
                  fontWeight: FontWeight.w600, letterSpacing: 0.2),
              ),
        ),
      ),
    );
  }
}
