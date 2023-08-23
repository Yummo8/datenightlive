import 'package:flutter/material.dart';
import 'package:DNL/common/values/colors.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/widgets/button.dart';
import 'package:DNL/view/profile/create_profile_page.dart';

class WelcomeProfilePage extends StatelessWidget {
  const WelcomeProfilePage({
    super.key,
  });

  static Page<void> page() =>
      const MaterialPage<void>(child: WelcomeProfilePage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const WelcomeProfilePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/images/2.png",
                fit: BoxFit.cover,
              )),
          Container(
              decoration: const BoxDecoration(
                gradient: ThemeColors.gradient,
              ),
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        const SizedBox(
                          height: 61,
                        ),
                        Image.asset(
                          "assets/icons/contact.png",
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "It's Time to make your profile beautiful!",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.getTitleStyle(
                              Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(children: <Widget>[
                          Expanded(
                              child: Button(
                                  title: "LET'S DO IT",
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push<void>(CreateProfilePage.route());
                                  })),
                        ]),
                        const SizedBox(height: 50),
                      ],
                    )
                  ]))
        ]));
  }
}
