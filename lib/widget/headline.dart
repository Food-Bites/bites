import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  const Headline({
    super.key,
    required this.closestCity,
    required this.text,
  });

  final String closestCity;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: text,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: closestCity,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
