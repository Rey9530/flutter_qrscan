import 'package:flutter/material.dart';
import 'package:flutter_qrscanner/providers/iu_provider.dart';
import 'package:provider/provider.dart';

class CustomeNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<UiProvider>(context);
    final currentIndex = providers.selectedMenuOpt;
    return BottomNavigationBar(
      onTap: (i) => providers.selectedMenuOpt = i,
      elevation: 0,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "Mapa",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: "Direcciones",
        ),
      ],
    );
  }
}
