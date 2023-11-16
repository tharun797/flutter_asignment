import 'package:flutter/material.dart';

class moveButton extends StatelessWidget {
  const moveButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
        child: Icon(icon),
      ),
    );
  }
}
