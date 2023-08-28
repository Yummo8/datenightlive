// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:DNL/common/utils/images.dart';
import 'package:DNL/common/values/constants.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/utils/logger.dart';
import 'package:DNL/common/widgets/static_progress_bar.dart';
import 'package:DNL/common/widgets/button.dart';
import 'package:DNL/core/blocs/info/info_bloc.dart';
import 'package:DNL/core/blocs/auth/auth_bloc.dart';
import 'package:DNL/core/blocs/profile/profile_bloc.dart';
import 'package:DNL/core/models/info_model.dart';
import 'package:DNL/view/info/widgets/profile_photos.dart';
import 'package:DNL/view/info/widgets/bio_input.dart';
import 'package:DNL/view/info/widgets/prompt/prompt_input.dart';
import 'package:DNL/view/welcome/welcome_done_page.dart';
import 'package:loader_overlay/loader_overlay.dart';

List<String> headings = [
  "Add your videos and photos",
  "Write a short bio about yourself",
  "Write your profile answers",
];

List<String> icons = [
  "gallery.svg",
  "bio.svg",
  "answers.svg",
];

class CreateInfoPage extends StatefulWidget {
  const CreateInfoPage({super.key});

  @override
  _CreateInfoPageState createState() => _CreateInfoPageState();

  static Page<void> page() => const MaterialPage<void>(child: CreateInfoPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const CreateInfoPage());
}

class _CreateInfoPageState extends State<CreateInfoPage> {
  List<dynamic> medias = [null, null, null, null, null, null];
  int _currentPage = 0;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    context.read<InfoBloc>();
  }

  void validate(InfoModel info) {
    bool validResult = false;

    if (_currentPage == 0) {
      validResult = true;
    }
    if (info.bio != null && _currentPage == 1) {
      validResult = true;
    }
    if (info.bio == "" && _currentPage == 1) {
      validResult = false;
    }
    if (_currentPage == 2) {
      validResult = true;
    }

    setState(() {
      _isValid = validResult;
    });
  }

  Widget _activePage() {
    InfoModel info = context.read<InfoBloc>().state.info;
    validate(info);

    switch (_currentPage) {
      case 0:
        return step1(info);
      case 1:
        return step2(info);
      case 2:
        return step3(info);
      default:
        return step1(info);
    }
  }

  void createInfo() async {
    try {
      User? authedUser = FirebaseAuth.instance.currentUser;
      InfoModel info = context.read<InfoBloc>().state.info;

      if (authedUser != null) {
        ProfileStatus profileState = context.read<ProfileBloc>().state.status;
        if (profileState == ProfileStatus.notCreated) {
          context.read<ProfileBloc>().add(const ProfileCreateRequested());
        }

        context.loaderOverlay.show();
        for (var i = 0; i < info.medias!.length; i++) {
          if (info.medias![i].type != "") {
            Media temp = await uploadMedia(authedUser.uid, info.medias![i]);
            info.medias![i] = temp;
          }
        }

        context.read<InfoBloc>().add(const InfoCreateRequested());
      }
    } catch (e) {
      logger.e("create error $e");
    }
  }

  void onBackPressed() {
    if (_currentPage == 0) {
      context.read<AuthBloc>().add(SignOutRequested());
    }
    setState(() {
      _currentPage = _currentPage >= 1 ? _currentPage - 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, profileState) {
              if (profileState.status == ProfileStatus.createLoading) {
                context.loaderOverlay.show();
              } else if (profileState.status == ProfileStatus.created) {
                context.loaderOverlay.hide();
              }
            },
            child: BlocListener<InfoBloc, InfoState>(
                listener: (context, infoState) {
                  if (infoState.status == InfoStatus.createLoading) {
                    context.loaderOverlay.show();
                  } else if (infoState.status == InfoStatus.created) {
                    context.loaderOverlay.hide();
                    if (context.read<ProfileBloc>().state.status ==
                        ProfileStatus.created) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push<void>(WelcomeDonePage.route());
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (_currentPage <= 2)
                                  Row(children: <Widget>[
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: StaticProgressBar(
                                          count: 3, current: _currentPage + 1),
                                    ),
                                    const SizedBox(width: 8),
                                  ]),
                                const SizedBox(height: 12),
                                SvgPicture.asset(
                                  "assets/icons/${icons[_currentPage]}",
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(headings[_currentPage],
                                    textAlign: TextAlign.left,
                                    style: CustomTextStyle.getTitleStyle(
                                        Theme.of(context)
                                            .colorScheme
                                            .onSecondary)),
                                const SizedBox(
                                  height: 24,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: _activePage(),
                                  ),
                                )
                              ],
                            ))),
                    Row(children: <Widget>[
                      const SizedBox(width: 24),
                      Expanded(
                          child: Button(
                              title: "BACK",
                              flag: true,
                              outlined: true,
                              onPressed: () {
                                setState(() {
                                  _currentPage--;
                                });
                                if (_currentPage < 0) {
                                  _currentPage = 0;
                                  Navigator.of(context).pop();
                                }
                              })),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Button(
                              title: "NEXT",
                              flag: true,
                              disabled: !_isValid,
                              onPressed: () {
                                setState(() {
                                  _currentPage++;
                                });
                                if (_currentPage >= 3) {
                                  _currentPage = 2;
                                  createInfo();
                                }
                              })),
                      const SizedBox(width: 24),
                    ]),
                    const SizedBox(height: 16),
                  ],
                ))));
  }

  Widget step1(InfoModel info) {
    return const ProfilePhotos();
  }

  Widget step2(InfoModel info) {
    return BioInput(
      bio: info.bio ?? "",
      onChange: (value) {
        context.read<InfoBloc>().add(InfoUpdated(info.copyWith(bio: value)));
      },
    );
  }

  Widget step3(InfoModel info) {
    return PromptInput(
        prompts: info.prompts ?? ["", "", ""],
        answers: info.answers ?? ["", "", ""]);
  }
}
