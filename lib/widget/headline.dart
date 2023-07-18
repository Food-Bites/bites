import 'package:flutter/material.dart';

/// The [Headline] class is a widget that displays a headline with a city name.
/// {@category Widgets}
class Headline extends StatelessWidget {
  const Headline({
    Key? key,
    required this.closestCity,
    required this.text,
    this.isSmall = false,
  }) : super(key: key);

  final String closestCity;
  final String text;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text.rich(
              TextSpan(
                text: '$text ',
                style: isSmall
                    ? Theme.of(context).textTheme.headlineMedium
                    : Theme.of(context).textTheme.displayMedium,
                children: [
                  TextSpan(
                    text: closestCity,
                    style: isSmall
                        ? Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary)
                        : Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
