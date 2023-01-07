import 'package:auto_trade/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({
    Key? key,
    required this.onRefresh,
    required this.header,
    required this.body,
  }) : super(key: key);

  final RefreshCallback onRefresh;
  final Widget header;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      body: RefreshIndicator(
        strokeWidth: 2,
        onRefresh: onRefresh,
        child: body,
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            elevation: .5,
            title: header,
            automaticallyImplyLeading: false,
            expandedHeight: 30,
            floating: true,
            snap: true,
            backgroundColor: Styles.whiteColor,
          ),
        ];
      },
    );
  }
}
