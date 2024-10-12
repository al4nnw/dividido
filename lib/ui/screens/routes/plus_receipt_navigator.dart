import 'package:dividido/ui/screens/plus_receipt/plus_receipt.dart';
import 'package:flutter/material.dart';

final plusReceiptNavigatorKey = GlobalKey<NavigatorState>();

class PlusReceiptNavigator extends StatelessWidget {
  const PlusReceiptNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: plusReceiptNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const PlusReceipt(),
        );
      },
    );
  }
}
