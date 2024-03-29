// ignore_for_file: use_colored_box

import 'package:diploma_frontend/widgets/default_table/default_table_header.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_item.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class DefaultCustomTable extends StatelessWidget {
  final DefaultTableHeader header;
  final List<DefaultTableItem> items;

  const DefaultCustomTable({
    super.key,
    required this.header,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? header
        : Expanded(
            child: Column(
              children: [
                header,
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: index % 2 != 0
                            ? Colors.white
                            : constants.Colors.greyTable,
                        child: items[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
