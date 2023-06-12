import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

class DefaultTableHeader extends StatelessWidget {
  final List<String> headers;
  final Color? color;
  const DefaultTableHeader({
    super.key,
    this.color,
    required this.headers,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      color: color ?? Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          headers.length,
          (index) => SizedBox(
            width: size.width * 0.72 / headers.length,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                headers[index].tr(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
