import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/widgets/button.dart';
import 'package:DNL/view/auth/auth_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: WelcomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/images/01.jpg",
                fit: BoxFit.cover,
              )),
          Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        Text(
                          'Date Night Live',
                          style: CustomTextStyle.getHeaderStyle(
                              Theme.of(context).colorScheme.secondary, 50),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Enjoy the true love',
                          style: CustomTextStyle.getTitleStyle(
                              Theme.of(context).colorScheme.secondary, 18),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(children: <Widget>[
                          const SizedBox(width: 8),
                          Expanded(
                              child: Button(
                                  title: "CREATE ACCOUNT",
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push<void>(SignupPage.route());
                                  })),
                          const SizedBox(width: 8),
                        ]),
                        const SizedBox(height: 16),
                        Row(children: <Widget>[
                          const SizedBox(width: 8),
                          Expanded(
                              child: Button(
                                  title: "SIGN IN",
                                  outlined: true,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push<void>(SignupPage.route());
                                  })),
                          const SizedBox(width: 8),
                        ]),
                        const SizedBox(height: 32),
                        Row(children: <Widget>[
                          const SizedBox(width: 8),
                          Expanded(
                              child:
                                  privacyPolicyLinkAndTermsOfService(context)),
                          const SizedBox(width: 8),
                        ]),
                        const SizedBox(height: 16),
                      ],
                    )
                  ]))
        ]));
  }

  Widget privacyPolicyLinkAndTermsOfService(BuildContext context) {
    TextStyle linkStyle = const TextStyle(
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.bold,
    );
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: CustomTextStyle.getSpanStyle(
            Theme.of(context).colorScheme.secondary, 13),
        children: <TextSpan>[
          const TextSpan(text: 'By signing up for App, you agree to our '),
          TextSpan(
              text: 'Terms of Service. ',
              style: linkStyle,
              recognizer: TapGestureRecognizer()..onTap = () {}),
          const TextSpan(text: 'Learn how we process your data in our '),
          TextSpan(
              text: 'Privacy Policy',
              style: linkStyle,
              recognizer: TapGestureRecognizer()..onTap = () {}),
          const TextSpan(text: ' and '),
          TextSpan(
              text: 'Cookies Policy',
              style: linkStyle,
              recognizer: TapGestureRecognizer()..onTap = () {}),
        ],
      ),
    );
  }
}
