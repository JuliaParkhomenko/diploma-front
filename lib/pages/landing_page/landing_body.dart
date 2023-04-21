import 'package:diploma_frontend/pages/landing_page/widgets/language_widget.dart';
import 'package:diploma_frontend/pages/landing_page/widgets/logo_widget.dart';
import 'package:diploma_frontend/pages/landing_page/widgets/sign_in_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:google_fonts/google_fonts.dart';

class LandingBody extends StatelessWidget {
  const LandingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 55,
          width: size.width,
          decoration: const BoxDecoration(
            color: constants.Colors.main,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 60,
              ),
              Center(
                child: LogoWidget(),
              ),
              const SizedBox(
                width: 14,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Organized',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40,
                    ),
                    child: Text(
                      'Warehouse',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: constants.Colors.logo,
                      ),
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              LanguageWidget(),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Accounting for products in warehouses'.tr(),
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: constants.Colors.main,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        text:
                            'Our help to you in accounting for food products in warehouses. Try it. '
                                .tr(),
                      ),
                      TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        text: 'It\'s as simple as that!'.tr(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                SignInButton(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * .2),
              child: Image.asset('assets/images/photo_warehouse.png'),
            )
          ],
        ),
      ],
    );
  }
}
