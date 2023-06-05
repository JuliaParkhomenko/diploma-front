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
          _getContainer(height: 6, width: 35, radius: 14),
          divider,
          _getContainer(height: 6, width: 35, radius: 14),
          divider,
          _getContainer(height: 18, width: 35, radius: 6),
        ],
      ),
    );
  }

  Widget get divider => const SizedBox(height: 4);

  Widget _getContainer({
    required double height,
    required double width,
    required double radius,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.orange,
        border: Border.all(
          width: .4,
        ),
      ),
    );
  }
}
