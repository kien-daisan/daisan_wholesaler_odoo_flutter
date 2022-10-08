import 'package:flutter/material.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';

class AppRestart extends StatefulWidget {
  final Widget child;

  AppRestart({required this.child});

  @override
  _AppRestartState createState() => _AppRestartState();

  static rebirth(BuildContext context) {
    context.findAncestorStateOfType<_AppRestartState>()!.restartApp();
  }
}

class _AppRestartState extends State<AppRestart> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }
  @override
  void initState() {
    AnalyticsEventsFirebase().appOpenEvent();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}
