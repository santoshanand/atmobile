import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/core/theme/app_theme.dart';
import 'package:auto_trade/screens/fund/fund_screen.dart';
import 'package:auto_trade/screens/profile/profile_screen.dart';
import 'package:auto_trade/screens/setting/setting_screen.dart';
import 'package:auto_trade/shared/auto_trade_logo.dart';
import 'package:auto_trade/shared/container_box.dart';
import 'package:auto_trade/shared/header_widget.dart';
import 'package:auto_trade/shared/page_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ServiceNotifier>().profile();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      body: Container(
        color: Styles.bgColor,
        child: const _ProfileWidget(),
      ),
      header: const HeaderWidget(
        title: 'Account',
      ),
      onRefresh: () async {
        context.read<ServiceNotifier>().profile();
      },
    );
  }
}

class _ProfileWidget extends StatelessWidget {
  const _ProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _goToPage(Widget widget) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
    }

    Future<void> _logout() async {
      Provider.of<ServiceNotifier>(context, listen: false).logout();
    }

    void _onTap(String value) {
      debugPrint(value);
      switch (value) {
        case "funds":
          _goToPage(const FundScreen());
          break;
        case "profile":
          _goToPage(const ProfileScreen());
          break;
        case "settings":
          _goToPage(const SettingScreen());
          break;
        case "logout":
          _logout();
          break;
        default:
      }
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: ListTile.divideTiles(context: context, tiles: [
              const _ProfileCard(),
              const _DetailsWidget(),
              const Gap(Styles.margin / 3),
              Container(
                color: Colors.white,
                child: ListTile(
                  title: const Text('Settings'),
                  trailing: const Icon(Iconsax.setting_2),
                  onTap: () {
                    _onTap('');
                  },
                ),
              ),
              const Gap(1),
              Container(
                color: Colors.white,
                child: ListTile(
                  title: const Text('Support'),
                  trailing: const Icon(Iconsax.info_circle),
                  onTap: () {
                    _onTap('');
                  },
                ),
              ),
              const Gap(1),
              Container(
                color: Colors.white,
                child: ListTile(
                  title: const Text('Contact'),
                  trailing: const Icon(Iconsax.call),
                  onTap: () {
                    _onTap('');
                  },
                ),
              ),
              const Gap(1),
              Container(
                color: Colors.white,
                child: ListTile(
                  title: const Text('Logout'),
                  trailing: const Icon(Iconsax.logout_1),
                  onTap: () {
                    _onTap('logout');
                  },
                ),
              ),
              const Gap(1),
              Container(
                color: Colors.white,
                child: const ListTile(
                  title: Text(
                    'Version 1.0.0',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
                child: Center(
                  child: AutoTradeLogo(),
                ),
              )
            ]).toList(),
          ),
        ),
      ],
    );
  }
}

class _DetailsWidget extends StatelessWidget {
  const _DetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<ServiceNotifier>(context).profileModel;
    if (profile == null) {
      return ContainerBox(
        padding: const EdgeInsets.all(Styles.margin),
        color: Colors.white,
        height: 130,
        child: SkeletonParagraph(
          style: SkeletonParagraphStyle(
            lines: 5,
            spacing: 6,
            lineStyle: SkeletonLineStyle(
              height: 10,
              borderRadius: BorderRadius.circular(6),
              maxLength: MediaQuery.of(context).size.width / 3,
            ),
          ),
        ),
      );
    }
    return ContainerBox(
      padding: const EdgeInsets.all(Styles.margin),
      color: Colors.white,
      height: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailsItem(
            label: "PAN",
            value: profile.pan,
          ),
          _DetailsItem(
            label: "Phone",
            value: profile.phone,
          ),
          Column(
              children: profile.bankAccounts
                  .map(
                    (e) => _DetailsItem(
                      label: e.name,
                      value: e.account,
                    ),
                  )
                  .toList())
        ],
      ),
    );
  }
}

class _DetailsItem extends StatelessWidget {
  const _DetailsItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<ServiceNotifier>(context).profileModel;
    if (profile == null) {
      return const _ProfileLoaderWidget();
    }
    return Padding(
      padding: const EdgeInsets.all(Styles.margin),
      child: ContainerBox(
        color: Colors.white,
        padding: const EdgeInsets.all(Styles.margin / 2),
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                profile.avatarUrl,
                width: 70,
                height: 70,
              ),
            ),
            const Gap(Styles.margin),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profile.userName,
                    style: Styles.titleMain,
                  ),
                  const Gap(Styles.margin / 3),
                  Text(
                    profile.userId,
                    style: Styles.titleUser,
                  ),
                  const Gap(Styles.margin / 3),
                  Text(
                    profile.email,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileLoaderWidget extends StatelessWidget {
  const _ProfileLoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerBox(
      color: Colors.white,
      padding: const EdgeInsets.all(Styles.margin / 2),
      margin: const EdgeInsets.all(Styles.margin / 2),
      height: 130,
      child: Row(
        children: [
          const SkeletonAvatar(
            style: SkeletonAvatarStyle(shape: BoxShape.circle, width: 70, height: 70),
          ),
          const Gap(Styles.margin / 2),
          Expanded(
            child: SizedBox(
              height: 64,
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 3,
                  spacing: 6,
                  lineStyle: SkeletonLineStyle(
                    height: 10,
                    borderRadius: BorderRadius.circular(6),
                    maxLength: MediaQuery.of(context).size.width / 3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
