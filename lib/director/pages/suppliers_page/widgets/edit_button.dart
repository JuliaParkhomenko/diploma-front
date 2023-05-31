import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
import 'package:diploma_frontend/manager/pages/widgets/info_overlay.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class EditButton extends StatelessWidget {
  final Function(bool) onTap;
  final int supplierId;
  final String name;
  final String address;
  final String email;
  final String phone;
  const EditButton({
    super.key,
    required this.supplierId,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await ServiceLocator.supplierRepository.edit(
          id: supplierId,
          name: name,
          address: address,
          email: email,
          phoneNum: phone,
        );
        onTap(true);
        showInfoPrikol('Successfully edited'.tr(context), context);
        final SupplierCubit cubit = BlocProvider.of(context);
        await cubit.fetchSuppliers('');
        Navigator.pop(context);
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.green.withOpacity(0.7)),
        backgroundColor: MaterialStateProperty.all(constants.Colors.main),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(),
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 160,
        child: Text(
          'Edit'.tr(context),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
