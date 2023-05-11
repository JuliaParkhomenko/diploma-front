import 'package:diploma_frontend/pages/landing_page/widgets/language_widget.dart';
import 'package:diploma_frontend/pages/landing_page/widgets/logo_widget.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:routemaster/routemaster.dart';

class LandingBody extends StatefulWidget {
  const LandingBody({super.key});

  @override
  State<LandingBody> createState() => _LandingBodyState();
}

class _LandingBodyState extends State<LandingBody> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 60,
          width: size.width,
          decoration: const BoxDecoration(
            color: constants.Colors.main,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60,
              ),
              Center(
                child: LogoWidget(),
              ),
              SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Organized',
                    style: TextStyle(
                      height: 2.45,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'InknutAntiqua',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40,
                    ),
                    child: Text(
                      'Warehouse',
                      style: TextStyle(
                        height: 0.85,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: constants.Colors.logo,
                        fontFamily: 'InknutAntiqua',
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
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
                  'Accounting for products in warehouses'.tr(context),
                  style: const TextStyle(
                    //height: 0.8,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: constants.Colors.main,
                    fontFamily: 'OpenSans',
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'OpenSans',
                        ),
                        text:
                            'Our help to you in accounting for food products in warehouses. Try it. '
                                .tr(context),
                      ),
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                        // ignore: avoid_escaping_inner_quotes
                        text: 'It\'s as simple as that!'.tr(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                signInButton(),
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

  Widget signInButton() {
    return InkWell(
      onTap: () => Routemaster.of(context).push('/sign-in'),
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          color: constants.Colors.mainButton,
          border: Border.all(
            width: 2,
            color: constants.Colors.mainButtonBorder,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          'Sign in'.tr(context).toUpperCase(),
          style: const TextStyle(
            color: constants.Colors.mainButtonText,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
