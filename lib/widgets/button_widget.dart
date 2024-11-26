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
          backgroundColor: isDisable
              ? Colors.grey
              : (color ?? const Color(0xFFFF7745)), // Cor padrão do botão
          foregroundColor: Colors.white, // Cor do texto em branco
        ).copyWith(
          // Cor de hover personalizada
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(MaterialState.hovered)) {
                return const Color(0xFF6750A4); // Cor de hover
              }
              return null;
            },
          ),
        ),
        onPressed: isDisable
            ? null
            : isLoading
                ? null
                : onPressed,
        child: isDisable
            ? child
            : isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : child,
      ),
    );
  }
}
