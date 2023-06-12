import 'package:diploma_frontend/widgets/default_table/default_table_header.dart';
import 'package:flutter/material.dart';

class DefaultTableItem extends StatelessWidget {
  final List<String> items;
  final Function() onTap;
  final Function()? onLongPressed;
  final DefaultTableHeader? header;
  final List<String>? subItems;

  const DefaultTableItem({
    super.key,
    this.onLongPressed,
    this.header,
    this.subItems,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _default(size, items),
        if (header != null) header!,
        if (subItems != null) _default(size, subItems!),
      ],
    );
  }

  Widget _default(Size size, List<String> values) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        fixedSize: MaterialStatePropertyAll(
          Size(size.width, 60),
        ),
        backgroundColor: MaterialStatePropertyAll(
          values == subItems ? Colors.orange.withOpacity(.8) : null,
        ),
      ),
      onLongPress: onLongPressed,
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          values.length,
          (index) => Container(
            alignment: Alignment.centerLeft,
            width: (size.width * 0.72) / values.length,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    values[index],
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
