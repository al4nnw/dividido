import 'package:dividido/ui/screens/home/home.dart';
import 'package:flutter/material.dart';

final groupNavigatorKey = GlobalKey<NavigatorState>();

class GroupNavigator extends StatelessWidget {
  const GroupNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: groupNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Home(),
        );
      },
    );
  }
}
