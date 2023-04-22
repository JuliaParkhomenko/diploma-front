import 'package:diploma_frontend/pages/landing_page/widgets/language_widget.dart';
import 'package:diploma_frontend/pages/landing_page/widgets/logo_widget.dart';
import 'package:diploma_frontend/services/language_service/language_service.dart';
import 'package:easy_localization/easy_localization.dart';
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
              const Center(
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
              LanguageWidget(
                onChange: (value) {
                  setState(() {
                    context.setLocale(value);
                  });
                },
              ),
              const SizedBox(
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
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: constants.Colors.main,
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
                        ),
                        text:
                            'Our help to you in accounting for food products in warehouses. Try it. '
                                .tr(),
                      ),
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        // ignore: avoid_escaping_inner_quotes
                        text: 'It\'s as simple as that!'.tr(),
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
          'Sign in'.tr().toUpperCase(),
          style: const TextStyle(
            color: constants.Colors.mainButtonText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}