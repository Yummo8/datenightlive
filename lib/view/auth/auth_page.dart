// ignore_for_file: implementation_imports, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:DNL/common/values/colors.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/utils/logger.dart';
import 'package:DNL/common/widgets/button.dart';
import 'package:DNL/common/widgets/phone_number_input/phone_number_input.dart';
import 'package:DNL/core/blocs/auth/auth_bloc.dart';
import 'package:DNL/view/auth/auth_otp_page.dart';
import 'package:DNL/common/widgets/static_progress_bar.dart';
import 'package:intl_phone_number_input/src/utils/phone_number.dart';
import 'package:intl_phone_number_input/src/utils/selector_config.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();

  static Page<void> page() => const MaterialPage<void>(child: SignupPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const SignupPage());
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController controller = TextEditingController();
  // String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: '');
  String phoneNumber = "";
  bool validated = false;
  bool showError = false;

  void handleSignUpWithPhone() {
    if (!validated) {
      return;
    }

    setState(() {
      showError = false;
    });

    context.read<AuthBloc>().add(PhoneSignInRequested(phoneNumber));
    Navigator.of(context)
        .push(AuthOTPPage.route(phoneNumber: phoneNumber, type: 'auth'));
  }

  void doSocialAuth(String type) async {
    try {
      if (type == 'google') {
        context.read<AuthBloc>().add(GoogleSignInRequested());
      } else {
        context.read<AuthBloc>().add(AppleSignInRequested());
      }
    } catch (e) {
      logger.e("doSocialAuth error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    const Row(children: <Widget>[
                      SizedBox(width: 8),
                      Expanded(
                        child: StaticProgressBar(count: 2, current: 1),
                      ),
                      SizedBox(width: 8),
                    ]),
                    const SizedBox(height: 12),
                    SvgPicture.asset(
                      "assets/icons/phone.svg",
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 12),
                    Text('Enter and verify Mobile Phone',
                        style: CustomTextStyle.getTitleStyle()),
                    const SizedBox(height: 34),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        setState(() {
                          phoneNumber = number.phoneNumber!;
                        });
                      },
                      onInputValidated: (bool value) {
                        setState(() {
                          validated = value;
                        });
                      },
                      selectorConfig: const SelectorConfig(
                          setSelectorButtonAsPrefixIcon: true),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      hintText: 'Phone number',
                      textStyle: const TextStyle(fontSize: 16),
                      errorMessage: '*Please enter a valid phone number',
                      selectorTextStyle:
                          const TextStyle(color: ThemeColors.primary),
                      initialValue: number,
                      textFieldController: controller,
                      selectorButtonOnErrorPadding: 0,
                      formatInput: false,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      spaceBetweenSelectorAndTextField: 0,
                      onSaved: (PhoneNumber number) {
                        setState(() {
                          number = number;
                        });
                      },
                    ),
                  ],
                )),
                Row(children: <Widget>[
                  const SizedBox(width: 8),
                  Expanded(
                      child: Button(
                          title: "BACK",
                          flag: true,
                          outlined: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                          })),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Button(
                          title: "NEXT",
                          flag: true,
                          disabled: !validated,
                          onPressed: () {
                            handleSignUpWithPhone();
                          })),
                  const SizedBox(width: 8),
                ]),
                const SizedBox(height: 16),
              ],
            )));
  }
}
