import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/screens/fund/fund_screen.dart';
import 'package:auto_trade/screens/profile/profile_screen.dart';
import 'package:auto_trade/screens/setting/setting_screen.dart';
import 'package:auto_trade/shared/auto_trade_logo.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<ServiceNotifier>().profile();
        },
        child: const _ProfileWidget(),
      ),
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
              ListTile(
                title: const Text('Support'),
                trailing: const Icon(Icons.help_outline_outlined),
                onTap: () {
                  _onTap('');
                },
              ),
              ListTile(
                title: const Text('Contact'),
                trailing: const Icon(Ionicons.call_outline),
                onTap: () {
                  _onTap('');
                },
              ),
              ListTile(
                title: const Text('Logout'),
                trailing: const Icon(Ionicons.log_out_outline),
                onTap: () {
                  _onTap('logout');
                },
              ),
              const ListTile(
                title: Text(
                  'Version 0.0.1',
                  style: TextStyle(fontWeight: FontWeight.w200),
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
      return Container();
    }
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        color: Color.fromARGB(61, 158, 158, 158),
      ),
      padding: const EdgeInsets.all(16),
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
          Container(
            child: const Text(
              "Accounts",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            padding: const EdgeInsets.only(top: 16, bottom: 8),
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
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Container(
        margin: const EdgeInsets.all(20.0),
        height: 150,
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                profile.avatarUrl,
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  profile.userId,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  profile.email,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
