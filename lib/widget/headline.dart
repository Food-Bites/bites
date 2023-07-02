import 'package:flutter/material.dart';

/// The [Headline] class is a widget that displays a headline with a city name.
/// {@category Widgets}
class Headline extends StatelessWidget {
  const Headline({
    Key? key,
    required this.closestCity,
    required this.text,
  }) : super(key: key);

  final String closestCity;
  final String text;

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
                style: Theme.of(context).textTheme.displayMedium,
                children: [
                  TextSpan(
                    text: closestCity,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
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
