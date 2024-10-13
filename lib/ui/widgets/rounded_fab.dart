import 'dart:async';
import 'package:flutter/material.dart';

class RoundedFab extends StatefulWidget {
  final IconData icon;
  final FutureOr<void> Function() onPressed;
  final String content;

  const RoundedFab({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.content,
  });

  @override
  State<RoundedFab> createState() => _RoundedFabState();
}

class _RoundedFabState extends State<RoundedFab> with TickerProviderStateMixin {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      clipBehavior: Clip.none,
      child: _isLoading
          ? const FloatingActionButton(
              onPressed: null,
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            )
          : FloatingActionButton.extended(
              onPressed: _handleOnPressed,
              label: Text(widget.content),
              icon: Icon(widget.icon),
            ),
    );
  }

  void _handleOnPressed() async {
    var result = widget.onPressed();
    if (result is Future) {
      setState(() {
        _isLoading = true;
      });
      await result;
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
