import 'package:flutter/material.dart';

class BidNowWidget extends StatelessWidget {
  const BidNowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '₹32.6L - 40.2L',
          style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
          decoration: BoxDecoration(
              color: Colors.cyan, borderRadius: BorderRadius.circular(30)),
          child: const Text(
            'Bid Now',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
