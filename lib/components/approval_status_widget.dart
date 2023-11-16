import 'package:flutter/material.dart';

class ApprovalStatusWidget extends StatelessWidget {
  const ApprovalStatusWidget(
      {super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 15),
          ),
        ),
        Text(
          body,
          style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
