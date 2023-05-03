import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.newtonCradle(
        color: constants.Colors.main,
        size: 200,
      ),
    );
  }
}
