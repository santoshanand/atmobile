import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ServiceNotifier>().profile();
    context.read<ServiceNotifier>().margin();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _paymentDialog(context);
      _launchURL();
    });
  }

  void _launchURL() {}

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ServiceNotifier>().profile();
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

Future<void> _paymentDialog(BuildContext context) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Make Payment',
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: 160,
          child: Column(
            children: [
              Text(
                Utils.formatCurrency(500),
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Yesterday's charge",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
          children: const [
            _LiveCardItem(), //Flexible
            SizedBox(
              width: 8,
            ), //SizedBox
            _LiveCardItem(), //Flexible
          ],
        ),
      ],
    );
  }
}

class _LiveCardItem extends StatelessWidget {
  const _LiveCardItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Card(
        margin: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 34, right: 34),
          height: 60,
          child: const _LiveCardBody(),
        ),
      ),
    );
  }
}

class _LiveCardBody extends StatelessWidget {
  const _LiveCardBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var margin = Provider.of<ServiceNotifier>(context).marginModel;

    if (margin == null) {
      return SkeletonLine(
        style: SkeletonLineStyle(
          height: 150,
          width: MediaQuery.of(context).size.width,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }
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
                child: Text(
                  Utils.formatCurrency(margin.equity?.net ?? 0),
                  style: const TextStyle(fontSize: 25, color: Colors.white),
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

class _HeaderView extends StatelessWidget {
  const _HeaderView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<ServiceNotifier>(context).profileModel;
    if (profile == null) {
      return const _ProfileLoaderWidget();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
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

class _ProfileLoaderWidget extends StatelessWidget {
  const _ProfileLoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Row(
        children: [
          const SkeletonAvatar(
            style: SkeletonAvatarStyle(shape: BoxShape.rectangle, width: 50, height: 50),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SkeletonParagraph(
              style: SkeletonParagraphStyle(
                lines: 3,
                spacing: 6,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 6,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 6,
                  maxLength: MediaQuery.of(context).size.width / 3,
                ),
              ),
            ),
          ),
          const SkeletonAvatar(
            style: SkeletonAvatarStyle(shape: BoxShape.circle, width: 32, height: 32),
          ),
        ],
      ),
    );
  }
}

class _SettingsWidget extends StatefulWidget {
  const _SettingsWidget({
    Key? key,
  }) : super(key: key);
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<_SettingsWidget> {
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
                    trailing: Consumer<ServiceNotifier>(
                      builder: (context, sn, child) {
                        return Switch(
                          onChanged: sn.stoppingTrading
                              ? null
                              : (value) {
                                  setState(() {
                                    stopTrading = value;
                                    Provider.of<ServiceNotifier>(context, listen: false).stopTrading(stopTrading);
                                  });
                                },
                          value: stopTrading,
                        );
                      },
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
