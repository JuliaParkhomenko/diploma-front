import 'dart:async';

import 'package:flutter/material.dart';

import 'package:diploma_frontend/constants/constants.dart' as constants;

void showInfoPrikol(String text, BuildContext context) {
  late final OverlayEntry overlay;
  final StreamController<double> opacity = StreamController<double>();
  double shototamOpasity = 1;
  opacity.add(1);
  overlay = OverlayEntry(builder: (context) {
    return Align(
      child: SizedBox(
        height: 100,
        width: 200,
        child: StreamBuilder<double>(
            stream: opacity.stream,
            builder: (context, snapshot) {
              return Container(
                alignment: Alignment.center,
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: constants.Colors.managerWarehouseMain
                      .withOpacity(snapshot.data ?? 1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              );
            }),
      ),
    );
  });
  Overlay.of(context).insert(overlay);
  final Timer timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
    shototamOpasity -= 0.01;
    opacity.add(shototamOpasity);
  });
  Future.delayed(const Duration(seconds: 3), () {
    timer.cancel();
    opacity.close();
    if (overlay.mounted) {
      overlay.remove();
    }
  });
}
