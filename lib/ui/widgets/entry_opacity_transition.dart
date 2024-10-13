import 'package:flutter/widgets.dart';

class EntryOpacityTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  const EntryOpacityTransition({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  State<EntryOpacityTransition> createState() => _EntryOpacityTransitionState();
}

class _EntryOpacityTransitionState extends State<EntryOpacityTransition> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: widget.duration,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: widget.child,
        );
      },
    );
  }
}
