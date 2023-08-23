// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/widgets/button.dart';
import 'package:DNL/common/widgets/static_progress_bar.dart';
import 'package:DNL/common/utils/logger.dart';
import 'package:DNL/core/blocs/auth/auth_bloc.dart';
import 'package:DNL/core/blocs/info/info_bloc.dart';
import 'package:DNL/core/blocs/profile/profile_bloc.dart';
import 'package:DNL/core/models/profile_model.dart';
import 'package:DNL/view/welcome/welcome_done_page.dart';
import 'package:DNL/view/welcome/welcome_info_page.dart';
import 'package:DNL/view/profile/widgets/name_input.dart';
import 'package:DNL/view/profile/widgets/birthday_choose.dart';
import 'package:DNL/view/profile/widgets/genders_choose.dart';
import 'package:DNL/view/profile/widgets/hometown_input.dart';
import 'package:DNL/view/profile/widgets/nationality_choose.dart';
import 'package:DNL/view/profile/widgets/religious_choose.dart';
import 'package:DNL/view/profile/widgets/smoke_choose.dart';
import 'package:DNL/view/profile/widgets/drink_choose.dart';
import 'package:DNL/view/profile/widgets/drug_choose.dart';
import 'package:loader_overlay/loader_overlay.dart';

List<String> headings = [
  "What's your name?",
  "What's your date of birth?",
  "Which gender best describes you?",
  "Where is your hometown?",
  "What is your nationality?",
  "What is your religious beliefs?",
  "Do you smoke?",
  "Do you drink?",
  "Do you use drugs",
];

List<String> icons = [
  "contact.svg",
  "cake.svg",
  "face.svg",
  "home.svg",
  "contact.svg",
  "religious.svg",
  "smoke.svg",
  "drink.svg",
  "drug.svg",
];

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();

  static Page<void> page() =>
      const MaterialPage<void>(child: CreateProfilePage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const CreateProfilePage());
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  int _currentPage = 0;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>();
  }

  void validate(ProfileModel profile) {
    bool validResult = false;

    if ((profile.firstname == null && _currentPage == 0) ||
        (profile.firstname?.isEmpty ?? true && _currentPage == 0)) {
      validResult = true;
    } else if ((profile.gender == null && _currentPage == 2) ||
        (profile.gender?.isEmpty == true && _currentPage == 2)) {
      validResult = true;
    } else if ((profile.town == null && _currentPage == 3) ||
        (profile.town?.isEmpty == true && _currentPage == 3)) {
      validResult = true;
    } else if ((profile.nation == null && _currentPage == 4) ||
        (profile.nation?.isEmpty == true && _currentPage == 4)) {
      validResult = true;
    } else if ((profile.religious == null && _currentPage == 5) ||
        (profile.religious?.isEmpty == true && _currentPage == 5)) {
      validResult = true;
    } else if ((profile.smoke == null && _currentPage == 6) ||
        (profile.smoke?.isEmpty == true && _currentPage == 6)) {
      validResult = true;
    } else if ((profile.drink == null && _currentPage == 7) ||
        (profile.drink?.isEmpty == true && _currentPage == 7)) {
      validResult = true;
    } else if ((profile.drug == null && _currentPage == 8) ||
        (profile.drug?.isEmpty == true && _currentPage == 8)) {
      validResult = true;
    }

    setState(() {
      _isValid = validResult;
    });
  }

  Widget _activePage() {
    ProfileModel profile = context.read<ProfileBloc>().state.profile;
    validate(profile);

    switch (_currentPage) {
      case 0:
        return step1(profile);
      case 1:
        return step2(profile);
      case 2:
        return step3(profile);
      case 3:
        return step4(profile);
      case 4:
        return step5(profile);
      case 5:
        return step6(profile);
      case 6:
        return step7(profile);
      case 7:
        return step8(profile);
      case 8:
        return step9(profile);
      default:
        return step1(profile);
    }
  }

  Widget _visibleProfilePage() {
    ProfileModel profile = context.read<ProfileBloc>().state.profile;
    switch (_currentPage) {
      case 0:
        return const SizedBox(height: 0);
      case 1:
        return const SizedBox(height: 0);
      case 2:
        return visibleStep3(profile);
      case 3:
        return visibleStep4(profile);
      case 4:
        return visibleStep5(profile);
      case 5:
        return visibleStep6(profile);
      case 6:
        return visibleStep7(profile);
      case 7:
        return visibleStep8(profile);
      case 8:
        return visibleStep9(profile);
      default:
        return const SizedBox(
          height: 0,
        );
    }
  }

  void createProfile() async {
    try {
      User? authedUser = FirebaseAuth.instance.currentUser;
      if (authedUser != null) {
        context.read<ProfileBloc>().add(const ProfileCreateRequested());
      }
    } catch (e) {
      logger.e("create account error $e");
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
    return BlocListener<ProfileBloc, ProfileState>(
        listener: ((context, profileState) {
          if (profileState.status == ProfileStatus.createLoading) {
            context.loaderOverlay.show();
          } else if (profileState.status == ProfileStatus.created &&
              context.read<InfoBloc>().state.status == InfoStatus.success) {
            context.loaderOverlay.hide();
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.of(context).push<void>(WelcomeDonePage.route());
          }
        }),
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(children: <Widget>[
                              const SizedBox(width: 8),
                              Expanded(
                                child: StaticProgressBar(
                                    count: 9, current: _currentPage + 1),
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
                                    Theme.of(context).colorScheme.onSecondary)),
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
                  const SizedBox(width: 18),
                  Expanded(
                    child: _visibleProfilePage(),
                  ),
                  const SizedBox(width: 24),
                ]),
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
                          disabled: _isValid,
                          onPressed: () {
                            setState(() {
                              _currentPage++;
                            });
                            if (_currentPage >= 9) {
                              _currentPage = 8;
                              if (context.read<InfoBloc>().state.status ==
                                  InfoStatus.notCreated) {
                                Navigator.of(context)
                                    .push<void>(WelcomeInfoPage.route());
                              }
                              if (context.read<InfoBloc>().state.status ==
                                  InfoStatus.success) {
                                createProfile();
                              }
                            }
                          })),
                  const SizedBox(width: 24),
                ]),
                const SizedBox(height: 16),
              ],
            )));
  }

  Widget step1(ProfileModel profile) {
    return NameInput(
        firstname: profile.firstname ?? "",
        lastname: profile.lastname ?? "",
        onChangeFirstname: (firstname) {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdated(profile.copyWith(firstname: firstname)));
        },
        onChangeLastname: (lastname) {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdated(profile.copyWith(lastname: lastname)));
        });
  }

  Widget step2(ProfileModel profile) {
    return BirthdayChoose(
      birthday: profile.birthday ?? DateTime.now(),
      onChange: (DateTime? value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(birthday: value)));
      },
    );
  }

  Widget step3(ProfileModel profile) {
    return GendersChoose(
      gender: profile.gender,
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(gender: value)));
      },
    );
  }

  Widget visibleStep3(ProfileModel profile) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      value: profile.genderVisibility ?? false,
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.secondary,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdated(profile.copyWith(genderVisibility: value)));
        });
      },
      title: const Text("Visible on my profile"),
    );
  }

  Widget step4(ProfileModel profile) {
    return HomeTownInput(
      town: profile.town ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(town: value)));
      },
    );
  }

  Widget visibleStep4(ProfileModel profile) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      value: profile.townVisibility ?? false,
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.secondary,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdated(profile.copyWith(townVisibility: value)));
        });
      },
      title: const Text("Visible on my profile"),
    );
  }

  Widget step5(ProfileModel profile) {
    return NationalityChoose(
      nation: profile.nation ?? [],
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(nation: value)));
      },
    );
  }

  Widget visibleStep5(ProfileModel profile) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      value: profile.nationVisibility ?? false,
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.secondary,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdated(profile.copyWith(nationVisibility: value)));
        });
      },
      title: const Text("Visible on my profile"),
    );
  }

  Widget step6(ProfileModel profile) {
    return ReligiousChoose(
      religious: profile.religious ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(religious: value)));
      },
    );
  }

  Widget visibleStep6(ProfileModel profile) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      value: profile.religiousVisibility ?? false,
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.secondary,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          context.read<ProfileBloc>().add(
              ProfileUpdated(profile.copyWith(religiousVisibility: value)));
        });
      },
      title: const Text("Visible on my profile"),
    );
  }

  Widget step7(ProfileModel profile) {
    return SmokeChoose(
      smoke: profile.smoke ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(smoke: value)));
      },
    );
  }

  Widget visibleStep7(ProfileModel profile) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      value: profile.smokeVisibility ?? false,
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.secondary,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdated(profile.copyWith(smokeVisibility: value)));
        });
      },
      title: const Text("Visible on my profile"),
    );
  }

  Widget step8(ProfileModel profile) {
    return DrinkChoose(
      drink: profile.drink ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(drink: value)));
      },
    );
  }

  Widget visibleStep8(ProfileModel profile) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      value: profile.drinkVisibility ?? false,
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.secondary,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdated(profile.copyWith(drinkVisibility: value)));
        });
      },
      title: const Text("Visible on my profile"),
    );
  }

  Widget step9(ProfileModel profile) {
    return DrugChoose(
      drug: profile.drug ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(drug: value)));
      },
    );
  }

  Widget visibleStep9(ProfileModel profile) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      value: profile.drugVisibility ?? false,
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.secondary,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdated(profile.copyWith(drugVisibility: value)));
        });
      },
      title: const Text("Visible on my profile"),
    );
  }
}
