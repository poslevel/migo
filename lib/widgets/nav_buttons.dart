import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.isActive = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        hoverColor: Colors.black,
        icon: Icon(
          icon,
          size: 24,
          color: isActive ? Colors.white : const Color(0xff6C6BA9),
        ),
      ),
    );
  }
}
