// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:diploma_frontend/blocs/application/application_cubit.dart';
import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class ApplicationTable extends StatefulWidget {
  final Function(List<int>) indexChanges;
  final String name;
  final bool past;
  const ApplicationTable({
    super.key,
    required this.past,
    required this.indexChanges,
    required this.name,
  });

  @override
  State<ApplicationTable> createState() => _ApplicationTableState();
}

class _ApplicationTableState extends State<ApplicationTable> {
  final List<Application> list = [];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (BuildContext context, state) {
        if (state is ApplicationInitial) {
          clearList();
          final ApplicationCubit cubit =
              BlocProvider.of<ApplicationCubit>(context);
          cubit.fetchApplications(
            warehouseName: widget.name,
            past: widget.past,
          );
        }
        if (state is ApplicationLoading) {
          clearList();

          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 60,
              child: getTableHeader(size),
            ),
          );
        }
        if (state is ApplicationError) {
          clearList();

          return Center(
            child: Text(state.error),
          );
        }

        if (state is ApplicationLoaded) {
          if (state.applications.isEmpty) {
            clearList();

            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 60,
                child: getTableHeader(size),
              ),
            );
          }

          return Flexible(
            child: Column(
              children: [
                getTableHeader(size),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.applications.length,
                    itemBuilder: (context, index) {
                      final Application item = state.applications[index];

                      return Container(
                        height: 60,
                        color: index % 2 != 0
                            ? (isSelected(item)
                                ? const Color(0xfff8a636)
                                : Colors.white)
                            : (isSelected(item)
                                ? const Color(0xfff8a636)
                                : constants.Colors.greyTable),
                        child: getItem(item, size),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget getTitle(
    String title,
    Size size, {
    bool bold = false,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      width: (size.width * 0.72 - 24) / 6,
      //color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'OpenSans',
                color: Colors.black,
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  void clearList() {
    list.clear();
  }

  void addToList(Application application) {
    if (widget.past) {
      return;
    }
    if (list.contains(application)) {
      setState(() {
        list.removeWhere((element) => element == application);
      });
    } else {
      setState(() {
        list.add(application);
      });
    }

    final List<int> result = [];

    for (final i in list) {
      result.add(i.id);
    }

    widget.indexChanges(result);
  }

  bool isSelected(Application application) {
    return list.contains(application);
  }

  Widget getItem(Application item, Size size) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        fixedSize: MaterialStatePropertyAll(
          Size(size.width * .72, 60),
        ),
      ),
      onPressed: () {
        addToList(item);
      },
      child: Row(
        children: [
          getTitle(item.urgency.tr(context), size),
          getTitle(item.productName, size),
          getTitle(item.kind, size),
          getTitle('${item.amount} ${item.productMeasurement}', size),
          getTitle(item.userName, size),
          getTitle(item.warehouseName, size),
        ],
      ),
    );
  }

  Widget getTableHeader(Size size) {
    return Container(
      alignment: Alignment.topCenter,
      height: 60,
      color: Colors.white,
      child: Row(
        children: [
          getTitle(
            'Urgency'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Product'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Kind'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Amount'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Manager'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Warehouse name'.tr(context),
            size,
            bold: true,
          ),
        ],
      ),
    );
  }
}
