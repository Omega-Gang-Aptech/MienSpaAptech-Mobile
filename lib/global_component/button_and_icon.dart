// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class ButtonAndIcon extends StatelessWidget {
  const ButtonAndIcon({
    Key? key,
    required this.textLabel,
    required this.icon,
    this.onTap,
    required this.priamry,
    required this.iconColor,
    required this.style,
  }) : super(key: key);
  final String textLabel;
  final IconData icon;
  final Color priamry;
  final Color iconColor;
  final TextStyle style;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: priamry,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              textLabel,
              style: style,
            )
          ],
        ),
      ),
    );
  }
}
