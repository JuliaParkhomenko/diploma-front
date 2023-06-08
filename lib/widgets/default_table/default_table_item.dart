import 'package:flutter/material.dart';

class DefaultTableItem extends StatelessWidget {
  final List<String> items;
  final Function() onTap;

  const DefaultTableItem({
    super.key,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        fixedSize: MaterialStatePropertyAll(
          Size(size.width * .72, 60),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: List.generate(
          items.length,
          (index) => Container(
            alignment: Alignment.centerLeft,
            width: (size.width * 0.72) / items.length,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    items[index],
                    //overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
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
