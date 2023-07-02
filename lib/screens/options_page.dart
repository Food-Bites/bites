import 'package:bites/utils/suggestions_switch.dart';
import 'package:bites/utils/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

/// The [OptionsPage] class is the page that displays the settings of the app.
/// {@category Screens}
class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  final _formKey = GlobalKey<FormState>();

  var form = {
    "foodName": "",
    "contactEmail": "",
  };

  // form submission
  void _submitForm(BuildContext context) {
    // show an alert dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Thank you!"),
          icon: const HeroIcon(HeroIcons.faceSmile),
          content: const Text(
              "Your suggestion has been submitted. We will review it and add it to the app if it meets our criteria. We may contact you to learn more about the food."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // become a professional
  void _becomeProfessional(BuildContext context) {
    // show an alert dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Thank you!"),
          icon: const HeroIcon(HeroIcons.faceSmile),
          content: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      'As now every professional must be verified by our team. To become a professional user you can contact us on ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                TextSpan(
                  text: 'professional@bites.food',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // show a placeholder page where settings will go
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      // add a switch to toggle dark mode
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Settings", style: Theme.of(context).textTheme.titleLarge),
            ListTile(
              title: const Text('Dark Mode'),
              contentPadding: const EdgeInsets.all(0),
              trailing: Switch(
                value: Provider.of<ThemeProvider>(context).themeType ==
                    ThemeType.dark,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setThemeType(value ? ThemeType.dark : ThemeType.light);
                },
              ),
            ),
            ListTile(
              title: const Text('Suggestions'),
              contentPadding: const EdgeInsets.all(0),
              trailing: Switch(
                value: Provider.of<SuggestionTipsProvider>(context).showTips,
                onChanged: (value) {
                  Provider.of<SuggestionTipsProvider>(context, listen: false)
                      .setShowTips(value);
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Propose a food",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            Text(
              "If you want to propose a food to be added to the app, please fill out the form below.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        form["foodName"] = value;
                      });
                    },
                    // clear the form on submit
                    onFieldSubmitted: (value) {
                      _formKey.currentState!.reset();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Food name',
                      border: OutlineInputBorder(),
                      icon: HeroIcon(HeroIcons.cake),
                    ),
                    initialValue: form["foodName"],
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        form["contactEmail"] = value;
                      });
                    },
                    // clear the form on submit
                    onFieldSubmitted: (value) {
                      _formKey.currentState!.reset();
                    },
                    // check if the email is valid
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    initialValue: form["contactEmail"],
                    decoration: const InputDecoration(
                      labelText: 'Contact email',
                      border: OutlineInputBorder(),
                      icon: HeroIcon(HeroIcons.envelope),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // submit the form
                        _submitForm(context);
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Be a professional",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            FilledButton.icon(
              onPressed: () {
                _becomeProfessional(context);
              },
              icon: const HeroIcon(HeroIcons.rocketLaunch),
              label: const Text("Start to promote your business"),
            ),
          ],
        ),
      ),
    );
  }
}
