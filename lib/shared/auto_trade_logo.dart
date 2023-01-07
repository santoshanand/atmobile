import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AutoTradeLogo extends StatelessWidget {
  const AutoTradeLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logo_small.svg',
      color: Colors.grey[400],
      height: 54,
      semanticsLabel: 'Options Buy',
    );
  }
}
