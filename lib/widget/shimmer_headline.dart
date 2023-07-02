import 'package:flutter/material.dart';

/// The [ShimmerHeadline] class is a utility widget to display a shimmering headline.
/// {@category Widgets}
class ShimmerHeadline extends StatefulWidget {
  const ShimmerHeadline({Key? key}) : super(key: key);

  @override
  State<ShimmerHeadline> createState() => ShimmerHeadlineState();
}

class ShimmerHeadlineState extends State<ShimmerHeadline>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _colorAnimation = ColorTween(begin: Colors.grey[300], end: Colors.grey[400])
        .animate(_controller);
    _widthAnimation =
        Tween<double>(begin: 200.0, end: 100.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: _widthAnimation.value,
          height: 24.0,
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(12.0),
          ),
        );
      },
    );
  }
}
