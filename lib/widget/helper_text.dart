import 'package:bites/utils/suggestions_switch.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

/// The [HelperText] class is a widget that displays a helper text with an icon.
/// {@category Widgets}
class HelperText extends StatelessWidget {
  const HelperText({Key? key, required this.icon, required this.text})
      : super(key: key);

  final IconType icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<SuggestionTipsProvider>(context).showTips) {
      return Column(
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              icon.getIconWidget(context),
              const SizedBox(
                width: 4.0,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
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

class IconType {
  final IconData? iconData;
  final HeroIcons? heroIcons;

  IconType.iconData(this.iconData) : heroIcons = null;

  IconType.heroIcons(this.heroIcons) : iconData = null;

  Widget getIconWidget(BuildContext context) {
    if (iconData != null) {
      return Icon(
        iconData,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      );
    } else if (heroIcons != null) {
      return HeroIcon(
        heroIcons!,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      );
    } else {
      throw Exception("Invalid IconType: both iconData and heroIcon are null");
    }
  }
}
