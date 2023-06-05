import 'package:diploma_frontend/blocs/batch/batch_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteOffAllButton extends StatelessWidget {
  final int id;
  const WriteOffAllButton({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await ServiceLocator.batchRepository.writeOffAll(id: id);
        final BatchCubit cubit = BlocProvider.of(context);
        cubit.clear();
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 160,
        decoration: BoxDecoration(
          //TODO change color
          color: Colors.redAccent,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        //TODO add style
        child: Text(
          'Write off all'.tr(context),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
