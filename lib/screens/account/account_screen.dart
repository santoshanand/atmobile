import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _profileData = ref.watch(profileProvider);
    void _onPressed() {
      ref.read(apiProvider).logout();
      ref.read(appProvider).setLoggedIn(false);
    }

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _profileData = ref.refresh(profileProvider);
        },
        child: _profileData.when(data: (_profile) {
          if (_profile == null) {
            return Container();
          }
          return ListView(
            padding: const EdgeInsets.only(top: 40.0),
            children: [
              CircleAvatar(
                radius: 90,
                backgroundImage: NetworkImage(_profile.avatarUrl),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  children: [
                    Text(
                      _profile.userName,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      _profile.broker,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(_profile.phone),
                    Text(_profile.pan),
                    Text(_profile.email),
                    OutlinedButton(
                      onPressed: _onPressed,
                      child: const Text("Logout"),
                    )
                  ],
                ),
              ),
            ],
          );
        }, error: (Object error, StackTrace stackTrace) {
          return const Center(
            child: Text("Something went wrong!"),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }),
      ),
    );
  }
}
