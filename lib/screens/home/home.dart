import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        var pr = await ref.refresh(profileProvider.future);
        ref.read(appProvider.notifier).setProfile(pr);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: const [
            _HeaderView(),
            _BodyView(),
          ],
        ),
      ),
    );
  }
}

class _BodyView extends StatelessWidget {
  const _BodyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          SizedBox(
            height: 8,
          ),
          _Amount(),
          SizedBox(
            height: 8,
          ),
          _LiveView(),
          SizedBox(
            height: 8,
          ),
          _ProfitLossHeader(),
          SizedBox(
            height: 8,
          ),
          _ProfitLoss(),
        ],
      ),
    );
  }
}

class _ProfitLossHeader extends StatelessWidget {
  const _ProfitLossHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Profit / Loss",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        TextButton(
          child: const Text(
            "See more",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}

class _ProfitLoss extends StatelessWidget {
  const _ProfitLoss({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black12),
              top: BorderSide(color: Colors.black12),
            ),
          ),
          child: const ListTile(
            title: Text(
              'NIFTY',
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              "23-12-2022",
              style: TextStyle(fontSize: 12),
            ),
            trailing: Text(
              "+200",
              style: TextStyle(fontSize: 12, color: Colors.green),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black12),
            ),
          ),
          child: const ListTile(
            title: Text(
              'BANKNIFTY',
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              "22-12-2022",
              style: TextStyle(fontSize: 12),
            ),
            trailing: Text(
              "+1500",
              style: TextStyle(fontSize: 12, color: Colors.green),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black12),
            ),
          ),
          child: const ListTile(
            title: Text(
              'FINNIFTY',
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              "21-12-2022",
              style: TextStyle(fontSize: 12),
            ),
            trailing: Text(
              "-10",
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

class _LiveView extends StatelessWidget {
  const _LiveView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Card(
                margin: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.only(top: 4, bottom: 4, left: 34, right: 34),
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("NIFTY"),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            "18000",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            "1.5%",
                            style: TextStyle(fontSize: 10, color: Colors.green),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ), //Flexible
            const SizedBox(
              width: 8,
            ), //SizedBox
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Card(
                child: Container(
                  padding: const EdgeInsets.only(top: 4, bottom: 4, left: 34, right: 34),
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("BANKNIFTY"),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            "42000",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            "-2%",
                            style: TextStyle(fontSize: 10, color: Colors.red),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ) //Flexible
          ],
        ),
      ],
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        color: Colors.black,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Total Portfolio Balance",
                style: TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.currency_rupee_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      "6,000.00",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Text(
                "+200 for today",
                style: TextStyle(color: Colors.green, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderView extends ConsumerWidget {
  const _HeaderView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var profile = ref.watch(appProvider).profile;
    if (profile == null) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: NetworkImage(profile.avatarUrl),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Happy Trading",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(profile.userShortname),
                    ],
                  ),
                )
              ],
            ),
            IconButton(
              icon: const Icon(
                Ionicons.settings_outline,
                color: Colors.grey,
              ),
              tooltip: 'Open Settings',
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return const _SettingsWidget();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsWidget extends ConsumerStatefulWidget {
  const _SettingsWidget({
    Key? key,
  }) : super(key: key);
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends ConsumerState<_SettingsWidget> {
  bool stopTrading = false;
  double profitValue = 1500;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView(
                children: ListTile.divideTiles(context: context, tiles: [
                  ListTile(
                    title: const Text('Stop Trading'),
                    trailing: Switch(
                      onChanged: (value) {
                        setState(() {
                          stopTrading = value;
                        });
                      },
                      value: stopTrading,
                    ),
                  ),
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Text("Profit"),
                        ),
                        Slider(
                          value: profitValue,
                          max: 1500,
                          divisions: 4,
                          min: 300,
                          label: profitValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              profitValue = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ]).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
