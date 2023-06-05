import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

class DefaultTableHeader extends StatelessWidget {
  final List<String> headers;
  const DefaultTableHeader({
    super.key,
    required this.headers,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        children: List.generate(
          headers.length,
          (index) => Container(
            alignment: Alignment.centerLeft,
            width: (size.width * 0.72 - 24) / headers.length,
            child: Row(
              children: [
                Padding(
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
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
