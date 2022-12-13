import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? bottomNavigationBar;
  const AppScaffold({Key? key, required this.body, required this.title, this.bottomNavigationBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              // backgroundColor: Colors.grey[300],
              floating: true,
              pinned: false,
              snap: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  title,
                  // style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ];
        },
        body: body,
      ),
    );
  }
}
