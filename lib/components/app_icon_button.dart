import 'package:flutter/material.dart';
import 'package:gite/themes/app_colors.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.size,
    this.color,
  }) : super(key: key);

  final Color? color;
  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: size,
      child: TextButton(
        onPressed: onPressed,
        child: Icon(
          icon,
          color: color ?? AppColors.dark,
        ),
      ),
    );
  }
}
