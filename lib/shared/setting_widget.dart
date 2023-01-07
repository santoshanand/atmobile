import 'package:auto_trade/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Iconsax.setting,
        color: Styles.iconColor,
      ),
      onTap: () {
        // showModalBottomSheet<void>(
        //   context: context,
        //   builder: (BuildContext context) {},
        // );
      },
    );
  }
}
