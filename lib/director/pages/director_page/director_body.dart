import 'package:diploma_frontend/director/pages/director_page/widgets/director_header.dart';
import 'package:diploma_frontend/director/pages/director_page/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class DirectorBody extends StatefulWidget {
  const DirectorBody({super.key});

  @override
  State<DirectorBody> createState() => _DirectorBodyState();
}

class _DirectorBodyState extends State<DirectorBody> {
  @override
  Widget build(BuildContext context) {
    final indexedPage = IndexedPage.of(context);
    final Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //! left-side menu
        NavBar(
          onIndexChanged: (index) {
            indexedPage.index = index;
          },
        ),
        //! header
        SizedBox(
          height: size.height,
          width: size.width - 170,
          child: Column(
            children: [
              DirectorHeader(
                selectedIndex: indexedPage.index,
                warehouses: const [],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: SizedBox(
                  height: size.height - 70,
                  child: PageStackNavigator(
                    stack: indexedPage.currentStack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
