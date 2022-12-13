import 'package:auto_trade/core/models/login_response.dart';
import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _profileData = ref.watch(profileProvider);

    void _onTap(String value) {
      debugPrint(value);
      switch (value) {
        case "funds":
          break;
        case "profile":
          break;
        case "settings":
          break;
        case "logout":
          ref.read(apiProvider).logout();
          ref.read(appProvider).setLoggedIn(false);
          break;
        default:
      }
    }

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _profileData = ref.refresh(profileProvider);
        },
        child: _profileData.when(data: (_profile) {
          return ListView(
            children: ListTile.divideTiles(context: context, tiles: [
              profileCard(_profile, context),
              ListTile(
                trailing: const Icon(Icons.currency_rupee_outlined),
                title: const Text('Funds'),
                onTap: () {
                  _onTap('funds');
                },
              ),
              ListTile(
                title: const Text('Profile'),
                trailing: const Icon(Icons.person_outline),
                onTap: () {
                  _onTap('profile');
                },
              ),
              ListTile(
                title: const Text('Settings'),
                trailing: const Icon(Icons.settings_outlined),
                onTap: () {
                  _onTap('settings');
                },
              ),
              ListTile(
                title: const Text('Logout'),
                trailing: const Icon(Icons.logout_outlined),
                onTap: () {
                  _onTap('Logout');
                },
              ),
              const ListTile(
                title: Text(
                  'Version 0.0.1',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ),
            ]).toList(),
          );
        }, error: (Object error, StackTrace stackTrace) {
          ref.refresh(apiProvider).logout();
          return Center(
            child: Text('Ooops! $error'),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }),
      ),
    );
  }

  Padding profileCard(ProfileModel _profile, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _profile.userId,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _profile.email,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  _profile.avatarUrl,
                  width: 60,
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
