// ignore_for_file: prefer_const_constructors, must_be_immutable, library_private_types_in_public_api, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/widgets/button.dart';
import 'package:DNL/common/widgets/pin_code_input.dart';
import 'package:DNL/common/widgets/static_progress_bar.dart';
import 'package:DNL/core/blocs/auth/auth_bloc.dart';

enum OTPState { notStarted, shouldArrive, sendAgain, didNotGetCode, success }

class AuthOTPPage extends StatefulWidget {
  String phoneNumber;
  String type;

  AuthOTPPage({super.key, required this.phoneNumber, required this.type});

  static Route<void> route({required phoneNumber, required type}) =>
      MaterialPageRoute<void>(
          builder: (_) => AuthOTPPage(phoneNumber: phoneNumber, type: type));

  @override
  _AuthOTPPageState createState() => _AuthOTPPageState();
}

class _AuthOTPPageState extends State<AuthOTPPage> {
  TextEditingController controller = TextEditingController(text: "");
  int pinLength = 6;
  bool hasError = false;
  String? OTPCode;
  OTPState step = OTPState.notStarted;
  int timeoutCount = 60;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeoutCount >= 0 && step == OTPState.shouldArrive) {
        setState(() {
          timeoutCount--;
        });
        if (timeoutCount == 0) {
          setState(() {
            step = OTPState.didNotGetCode;
          });
        }
      }
    });

    AuthState authState = context.read<AuthBloc>().state;
    if (authState is AuthLoading && authState.type == "PhoneSignInRequested") {
      context.loaderOverlay.show();
    }
    setState(() {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void countSeconds() {
    context.read<AuthBloc>().add(PhoneSignInRequested(widget.phoneNumber));
    controller.clear();
    setState(() {
      timeoutCount = 0;
      step = OTPState.notStarted;
    });
  }

  void onNextProcess() async {
    context.read<AuthBloc>().add(VerifyOTPRequested(controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading && state.type == "PhoneSignInRequested") {
            context.loaderOverlay.show();
            return;
          } else if (state is AuthLoading &&
              state.type == "VerifyOTPRequested") {
            context.loaderOverlay.show();
            return;
          } else if (state is AuthLoading && state.type == "SMSCodeSent") {
            setState(() {
              timeoutCount = 60;
              step = OTPState.shouldArrive;
            });
          }
          if (state is Authenticated) {
            setState(() {
              timeoutCount = 0;
              step = OTPState.success;
            });
          }
          if (state is AuthError) {
            setState(() {
              timeoutCount = 0;
              step = OTPState.sendAgain;
            });
          }
          context.loaderOverlay.hide();
        },
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Row(children: const <Widget>[
                          SizedBox(width: 8),
                          Expanded(
                            child: StaticProgressBar(count: 2, current: 2),
                          ),
                          SizedBox(width: 8),
                        ]),
                        const SizedBox(height: 12),
                        SvgPicture.asset(
                          "assets/icons/verify.svg",
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 12),
                        Text('Enter your verification code',
                            style: CustomTextStyle.getTitleStyle()),
                        const SizedBox(height: 12),
                        Text('The code has been sent to your number:',
                            style: CustomTextStyle.getDescStyle(
                                Theme.of(context).colorScheme.onSurface)),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            style: CustomTextStyle.getDescStyle(
                                Theme.of(context).colorScheme.onSurface),
                            children: <TextSpan>[
                              TextSpan(text: "${widget.phoneNumber} "),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        PinCodeTextField(
                          autofocus: true,
                          controller: controller,
                          hideCharacter: false,
                          highlight: false,
                          defaultBorderColor:
                              Theme.of(context).colorScheme.onSurface,
                          hasTextBorderColor:
                              Theme.of(context).colorScheme.primary,
                          maxLength: pinLength,
                          hasError: hasError,
                          onTextChanged: (text) {
                            setState(() {
                              hasError = false;
                            });
                          },
                          onDone: (text) {
                            // onNextProcess(text);
                            setState(() {
                              OTPCode = text;
                            });
                          },
                          hasUnderline: true,
                          wrapAlignment: WrapAlignment.spaceBetween,
                          pinTextStyle: const TextStyle(fontSize: 28.0),
                          pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                          pinBoxColor: Colors.transparent,
                          pinTextAnimatedSwitcherDuration:
                              const Duration(milliseconds: 300),
                          highlightAnimationBeginColor:
                              Theme.of(context).colorScheme.onSecondary,
                          highlightAnimationEndColor: Colors.white12,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    )),
                    const SizedBox(height: 20),
                    if (step == OTPState.shouldArrive)
                      textArrivedIn(timeoutCount)
                    else if (step == OTPState.didNotGetCode)
                      dontGetACode()
                    else if (step == OTPState.sendAgain)
                      sendAgain(),
                    const SizedBox(height: 20),
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
                              onPressed: () {
                                onNextProcess();
                              })),
                      const SizedBox(width: 8),
                    ]),
                    const SizedBox(height: 16),
                  ],
                ))));
  }

  Widget textArrivedIn(int seconds) {
    return RichText(
      text: TextSpan(
        style: CustomTextStyle.getDescStyle(
            Theme.of(context).colorScheme.onSecondary),
        children: <TextSpan>[
          TextSpan(text: 'Code is available within ${seconds}s.'),
        ],
      ),
    );
  }

  Widget sendAgain() {
    TextStyle linkStyle = const TextStyle(decoration: TextDecoration.underline);
    return RichText(
      text: TextSpan(
        style: CustomTextStyle.getDescStyle(
            Theme.of(context).colorScheme.onSecondary),
        children: <TextSpan>[
          const TextSpan(text: 'Wrong code. Please '),
          TextSpan(
              text: 'send again',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  countSeconds();
                  controller.clearComposing();
                }),
        ],
      ),
    );
  }

  Widget dontGetACode() {
    TextStyle linkStyle = const TextStyle(decoration: TextDecoration.underline);
    return RichText(
      text: TextSpan(
        style: CustomTextStyle.getDescStyle(
            Theme.of(context).colorScheme.onSecondary),
        children: <TextSpan>[
          TextSpan(
              text: 'Didn\'t get a code?',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  countSeconds();
                }),
        ],
      ),
    );
  }
}
