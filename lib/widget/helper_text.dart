import 'package:bites/utils/suggestions_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelperText extends StatelessWidget {
  const HelperText({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<SuggestionTipsProvider>(context).showTips) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            child: Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox(
        height: 0.0,
      );
    }
  }
}
