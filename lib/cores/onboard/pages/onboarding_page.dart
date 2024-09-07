import 'package:flutter/material.dart';
import 'package:poets_paradise/config/routes.dart';
import 'package:poets_paradise/cores/onboard/onboarding_info.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: isLastPage
            ? _getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        pageController.jumpToPage(controller.items.length - 1);
                      },
                      child: const Text('Skip')),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    effect: const WormEffect(
                        activeDotColor: AppPallete.purpleColor),
                  ),
                  TextButton(
                      onPressed: () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      },
                      child: const Text('Next')),
                ],
              ),
      ),
      // backgroundColor: Color.fromARGB(255, 209, 209, 209),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: PageView.builder(
          onPageChanged: (value) => setState(() {
            isLastPage = controller.items.length - 1 == value;
          }),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  height: 400,
                  child: Image.asset(
                    controller.items[index].image,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.items[index].title,
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: (Colors.deepPurple)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  controller.items[index].description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _getStarted() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(AppRoute.signin);
      },
      child: const Text('Get Started'),
    );
  }
}
