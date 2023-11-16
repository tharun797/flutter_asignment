import 'package:flutter/material.dart';

class EligibilityWidget extends StatelessWidget {
  const EligibilityWidget(
      {super.key, required this.title, required this.image});

  final String title;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        image,
        const SizedBox(
          width: 10,
        ),
        Flexible(
            child: Text(
          title,
          style: const TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w500),
        )),
      ],
    );
  }
}
