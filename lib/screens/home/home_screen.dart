import 'package:auto_trade/core/models/home_model.dart';
import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/core/theme/app_theme.dart';
import 'package:auto_trade/shared/container_box.dart';
import 'package:auto_trade/shared/loaders/header_loader.dart';
import 'package:auto_trade/shared/page_widget.dart';
import 'package:auto_trade/shared/setting_widget.dart';
import 'package:auto_trade/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      onRefresh: () async {
        context.read<ServiceNotifier>().homeData();
      },
      body: Container(
        color: Styles.bgColor,
        child: ListView(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(Styles.margin),
              child: _Amount(
                height: 140,
              ),
            ),
            _PositionWidget()
          ],
        ),
      ),
      header: const _HeaderView(),
    );
  }
}

class _PositionWidget extends StatelessWidget {
  const _PositionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeModel = context.watch<ServiceNotifier>().homeModel;
    if (homeModel == null) {
      return const _LoadingPositionWidget();
    }

    // homeModel.positions = [];
    if (homeModel.positions!.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.8,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/empty.svg',
                height: 120,
                semanticsLabel: 'Options Buy',
              ),
              const Gap(20),
              Text(
                "No positions",
                style: Styles.emptyStyle,
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: Styles.gap / 2, right: Styles.gap / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: Styles.gap / 2, bottom: Styles.gap / 2),
            child: Text(
              "Today's Positions",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Column(
            children: homeModel.positions!.map((e) {
              return _PositionItemWidget(
                position: e,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PositionItemWidget extends StatelessWidget {
  const _PositionItemWidget({
    Key? key,
    required this.position,
  }) : super(key: key);

  final Position? position;

  final String _nifty = "NIFTY";
  final String _bankNifty = "BANKNIFTY";
  @override
  Widget build(BuildContext context) {
    var profit = position?.m2m;
    var profitStr = profit != null && profit > 0 ? '+${profit.toStringAsFixed(2)}' : profit?.toStringAsFixed(2);

    var symbol = position?.tradingsymbol ?? '';
    var qty = '${position?.buyquantity} Qty';
    var buyPrice = 'Buy ${position?.buyprice?.toStringAsFixed(2)}';
    var sellPrice = 'Sell ${position?.sellprice?.toStringAsFixed(2)}';
    var product = position?.product ?? '';

    String tradingSymbol() {
      //NIFTY2311217900PE
      var firstPart = '';
      var date = '';
      var strikePrice = '';

      var niftyIndex = symbol.indexOf(_nifty);
      if (niftyIndex == -1) {
        return symbol;
      }

      if (niftyIndex == 0) {
        firstPart = symbol.substring(0, _nifty.length);
      } else {
        // format BANKNIFTY
        firstPart = symbol.substring(0, _bankNifty.length);
      }
      if (symbol.length > 10) {
        date = symbol.substring(symbol.length - 9, symbol.length - 7);
        strikePrice = symbol.substring(symbol.length - 7, symbol.length);
      }
      return '$firstPart $date $strikePrice';
    }

    return ClipRect(
      child: Banner(
        location: BannerLocation.topStart,
        message: 'MANUAL',
        color: Colors.red,
        child: Container(
          padding: const EdgeInsets.all(Styles.gap / 2),
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
            color: Styles.whiteColor,
          ),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    qty,
                    style: Styles.listItemTop,
                  ),
                  Text(
                    buyPrice,
                    style: Styles.listItemTop,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: Styles.gap / 2, bottom: Styles.gap / 2),
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: [
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  width: 14,
                                  height: 14,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  "W",
                                  style: Styles.badgeCircleText,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: Styles.gap / 3),
                              child: Text(
                                tradingSymbol(),
                                style: Styles.title,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      profitStr ?? '',
                      style: profit != null && profit > 0 ? Styles.greenStyle : Styles.redStyle,
                    ),
                  ],
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                      color: Color(0x20000000),
                    ),
                    child: Text(
                      product,
                      style: Styles.badge,
                    ),
                  ),
                  Text(
                    sellPrice,
                    style: Styles.listItemTop,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingPositionWidget extends StatelessWidget {
  const _LoadingPositionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Styles.gap / 2, right: Styles.gap / 2),
      child: Column(
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 20,
              width: MediaQuery.of(context).size.width / 2,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(8),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 100,
              width: MediaQuery.of(context).size.width,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(8),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 100,
              width: MediaQuery.of(context).size.width,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(8),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 100,
              width: MediaQuery.of(context).size.width,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(8),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 100,
              width: MediaQuery.of(context).size.width,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(8),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 100,
              width: MediaQuery.of(context).size.width,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;
  @override
  Widget build(BuildContext context) {
    var homeModel = context.watch<ServiceNotifier>().homeModel;
    if (homeModel == null) {
      return SkeletonLine(
        style: SkeletonLineStyle(
          height: height,
          width: MediaQuery.of(context).size.width,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }

    var pnl = homeModel.fund?.pnl ?? 0;
    var formattedProfit = pnl > 0 ? '+${Utils.formatWithoutCurrencySymbol(pnl)}' : Utils.formatWithoutCurrencySymbol(pnl);
    return ContainerBox(
      color: Styles.colorBlack_37414F,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Account Balance",
                style: TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: Text(
                  Utils.formatCurrency(homeModel.fund?.total ?? 0),
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              Text(
                pnl == 0 ? '' : formattedProfit,
                style: pnl > 0 ? Styles.greenStyle : Styles.redStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeModel = Provider.of<ServiceNotifier>(context).homeModel;

    if (homeModel == null || homeModel.profile == null) {
      return const HeaderLoader();
    }

    var profile = homeModel.profile;
    var userName = profile?.userShortname ?? '';
    var avatarUrl = profile?.avatarUrl ?? '';

    return Container(
      color: Styles.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _TitleAndImageWidget(
            userName: userName,
            avatarUrl: avatarUrl,
          ),
          const SettingWidget(),
        ],
      ),
    );
  }
}

class _TitleAndImageWidget extends StatelessWidget {
  const _TitleAndImageWidget({
    Key? key,
    required this.avatarUrl,
    required this.userName,
  }) : super(key: key);

  final String avatarUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AvatarWidget(
          avatarUrl: avatarUrl,
        ),
        _HeaderTitleWidget(
          title: userName,
        )
      ],
    );
  }
}

class _HeaderTitleWidget extends StatelessWidget {
  const _HeaderTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Styles.gap / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Happy Trading",
            style: Styles.subhead,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            title,
            style: Styles.title,
          ),
        ],
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({
    Key? key,
    required this.avatarUrl,
  }) : super(key: key);

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Styles.iconColor,
        image: DecorationImage(
          image: NetworkImage(avatarUrl),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
  }
}
