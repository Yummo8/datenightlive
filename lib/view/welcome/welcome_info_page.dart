import 'package:flutter/material.dart';
import 'package:DNL/common/values/colors.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/widgets/button.dart';
import 'package:DNL/view/info/create_info_page.dart';

class WelcomeInfoPage extends StatelessWidget {
  const WelcomeInfoPage({
    super.key,
  });

  static Page<void> page() =>
      const MaterialPage<void>(child: WelcomeInfoPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const WelcomeInfoPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/images/3.png",
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
                          "assets/icons/face.png",
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Showcase the person\n behind the profile\n using media and\n prompts",
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
                                        .push<void>(CreateInfoPage.route());
                                  })),
                        ]),
                        const SizedBox(height: 50),
                      ],
                    )
                  ]))
        ]));
  }
}
