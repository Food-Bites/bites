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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 32, 16.0, 32.0),
      child: Expanded(
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: text,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(width: 10.0),
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
    );
  }
}
