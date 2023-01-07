import 'package:auto_trade/core/theme/app_theme.dart';
import 'package:auto_trade/screens/trade/search_screen.dart';
import 'package:auto_trade/shared/container_box.dart';
import 'package:auto_trade/shared/header_widget.dart';
import 'package:auto_trade/shared/page_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var sp = ref.watch(tradesProvider);
    return PageWidget(
      header: const HeaderWidget(
        title: 'Trades',
      ),
      onRefresh: () async {},
      body: Container(
        color: Styles.bgColor,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(Styles.margin),
              child: GestureDetector(
                onTap: () {
                  showSearch(
                      context: context,
                      // delegate to customize the search bar
                      delegate: CustomSearchDelegate());
                },
                child: ContainerBox(
                  padding: const EdgeInsets.all(Styles.margin),
                  color: const Color(0xffeeeeee),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Icon(
                        Iconsax.search_normal_1,
                        color: Styles.iconColor,
                        size: 20,
                      ),
                      const Gap(8),
                      Text(
                        "Search",
                        style: Styles.searchStyle,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
