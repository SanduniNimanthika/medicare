import 'package:flutter/material.dart';

import 'package:medicare/commanpages/configue.dart';

class Responsive extends StatelessWidget {
  final Widget portraitLayout;
  final Widget landscapeLayout;
  const Responsive ({
    Key key,
    @required this.portraitLayout,
    this.landscapeLayout,
  }):super (key:key);
  @override
  Widget build(BuildContext context) {
    if (SizeConfig.isPortrait && SizeConfig.isMobilePortrait){
      return portraitLayout;
    } else{
      return landscapeLayout;
    }

  }

}
