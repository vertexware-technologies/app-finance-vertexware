import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final bool isLoading;
  final bool isDisable;
  final Widget child;
  final double width;
  final double height;
  final Function() onPressed;
  final Color? color;
  const ButtonWidget({
    super.key,
    required this.child,
    required this.onPressed,
    this.isLoading = false,
    this.isDisable = false,
    this.width = 220,
    this.height = 48,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            backgroundColor: color ?? Theme.of(context).primaryColor),
        onPressed: isDisable
            ? null
            : isLoading
                ? null
                : onPressed,
        child: isDisable
            ? child
            : isLoading
                ? const CircularProgressIndicator(backgroundColor: Colors.white)
                : child,
      ),
    );
  }
}
