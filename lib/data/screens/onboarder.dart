import 'package:bites/data/screens/main_layout.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The [OnboarderPage] class is the root widget of the onboarder. It is a stateful widget. It is wrapped in a [PageView] widget.
/// {@category Screens}
class OnboarderPage extends StatefulWidget {
  const OnboarderPage({Key? key}) : super(key: key);

  @override
  State<OnboarderPage> createState() => OnboarderPageState();
}

class OnBoardScreen {
  final String title;
  final String description;
  final String image;
  final Color? color;

  OnBoardScreen({
    required this.title,
    required this.description,
    required this.image,
    this.color,
  });
}

class OnboarderPageState extends State<OnboarderPage> {
  bool acceptedLicense = false;
  final outerScrollController = PageController();
  final innerScrollController = PageController();
  double innerScrollPosition = 0;

  final Map<String, OnBoardScreen> steps = {
    "Splash": OnBoardScreen(
      title: "Welcome to Bites!",
      description: "A new way to explore typical food around you.",
      image: "assets/logo-vertical.png",
    ),
    "Map": OnBoardScreen(
        title: "Explore",
        description:
            "See what's around you on the map, and tap on an area to find out more.",
        image: "assets/map21.png"),
    "Discover": OnBoardScreen(
      title: "Discover",
      description:
          "Get to know the food events happening around you, and review places you visited.",
      image: "assets/discover21.png",
    ),
    "Market": OnBoardScreen(
      title: "Market",
      description:
          "Buy the most genuine and typical products directly from the vendor",
      image: "assets/market21.png",
    ),
    "GoToApp": OnBoardScreen(
      title: "Ready? Let's get started!",
      description: "",
      image: "assets/letsgo21.png",
    ),
  };

  /// The _nextPage function is used to navigate to the next page in the onboarder.
  void _nextPage() {
    if (innerScrollPosition < steps.length - 1) {
      setState(() {
        innerScrollPosition++;
      });
      innerScrollController.animateToPage(
        innerScrollPosition.toInt(),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// The _setOnboarderSeen function is used to set the onboarder as seen and navigate to the main layout.
  void _setOnboarderSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarderSeen', true);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainLayout(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: innerScrollPosition == 4 && !acceptedLicense
          ? null
          : FloatingActionButton.small(
              onPressed:
                  innerScrollPosition != 4.00 ? _nextPage : _setOnboarderSeen,
              child: innerScrollPosition != 4.00
                  ? const Icon(Icons.arrow_forward)
                  : const Icon(Icons.check),
            ),
      body: Stack(
        children: [
          PageView(
            controller: innerScrollController,
            onPageChanged: (val) {
              setState(() {
                innerScrollPosition = val.toDouble();
              });
            },
            children: [
              for (var step in steps.entries)
                OnboardStep(
                  [
                    Text(
                      step.value.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      step.value.description,
                      textAlign: TextAlign.center,
                    ),
                    if (step.key == "GoToApp")
                      Column(
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Dialog.fullscreen(
                                    child: Scaffold(
                                      appBar: AppBar(
                                        title: const Text('License Agreement'),
                                      ),
                                      body: const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Center(
                                          child: Text(
                                              'This is where the license agreement would go.'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: const HeroIcon(
                                HeroIcons.clipboardDocumentCheck),
                            label: const Text("Read the license agreement"),
                          ),
                          IntrinsicWidth(
                            // max width of checkbox list tile
                            child: CheckboxListTile(
                              value: acceptedLicense,
                              onChanged: (val) {
                                setState(() {
                                  acceptedLicense = val ?? false;
                                });
                              },
                              title: Text(
                                "I have read and accept the license agreement",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                  color: step.value.color,
                  image: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(step.value.image),
                  ),
                ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DotsIndicator(
                dotsCount: 5,
                position: innerScrollPosition.toInt(),
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardStep extends StatelessWidget {
  final Widget? image;
  final List<Widget> children;
  final Color? color;

  const OnboardStep(
    this.children, {
    super.key,
    this.image,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: color,
        // color: Colors.blueAccent,
        child: Column(
          children: [
            if (image != null)
              Expanded(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      // elevation: 10,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      child: image!,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
