import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      width: 35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 6,
            width: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.orange,
              border: Border.all(
                width: .4,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 6,
            width: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.orange,
              border: Border.all(
                width: .4,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 18,
            width: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.orange,
              border: Border.all(
                width: .4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
