// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:DNL/common/utils/images.dart';
import 'package:DNL/common/values/constants.dart';
import 'package:DNL/view/profile/widgets/bio_input.dart';
import 'package:DNL/view/profile/widgets/dategender_choose.dart';
import 'package:DNL/view/profile/widgets/height.dart';
import 'package:DNL/view/profile/widgets/music_choose.dart';
import 'package:DNL/view/profile/widgets/profile_photos.dart';
import 'package:DNL/view/profile/widgets/relStatus.dart';
import 'package:DNL/view/profile/widgets/search_choose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/widgets/button.dart';
import 'package:DNL/common/widgets/static_progress_bar.dart';
import 'package:DNL/common/utils/logger.dart';
import 'package:DNL/core/blocs/auth/auth_bloc.dart';
import 'package:DNL/core/blocs/profile/profile_bloc.dart';
import 'package:DNL/core/models/profile_model.dart';
import 'package:DNL/view/welcome/welcome_done_page.dart';
import 'package:DNL/view/profile/widgets/name_input.dart';
import 'package:DNL/view/profile/widgets/birthday_choose.dart';
import 'package:DNL/view/profile/widgets/genders_choose.dart';
import 'package:DNL/view/profile/widgets/hometown_input.dart';
import 'package:DNL/view/profile/widgets/smoke_choose.dart';
import 'package:DNL/view/profile/widgets/drink_choose.dart';
import 'package:loader_overlay/loader_overlay.dart';

List<String> headings = [
  "What's your name?",
  "What's your gender?",
  "Birthday and zodiac sign",
  "Height and body type",
  "Where is your location?",
  "What is your relationship status?",
  "Do you smoke?",
  "Do you drink?",
  "Add your videos and photos",
  "Write a short bio about yourself",
  "Favorite music genres",
  "What are you looking for?",
  "Looking to date?",
  "Distance preference",
];

List<String> icons = [
  "contact.svg",
  "face.svg",
  "cake.svg",
  "height.svg",
  "home.svg",
  "relationship.svg",
  "smoke.svg",
  "drink.svg",
  "gallery.svg",
  "bio.svg",
  "music.svg",
  "search.svg",
  "selfcare.svg",
  "distance.svg",
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
  List<Media> medias = [];
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
    } else if ((profile.gender == null && _currentPage == 1) ||
        (profile.gender?.isEmpty == true && _currentPage == 1)) {
      validResult = true;
    } else if ((profile.height == null && _currentPage == 3) ||
        (profile.height?.isEmpty == true && _currentPage == 3)) {
      validResult = true;
    } else if ((profile.town == null && _currentPage == 4) ||
        (profile.town?.isEmpty == true && _currentPage == 4)) {
      validResult = true;
    } else if ((profile.relStatus == null && _currentPage == 5) ||
        (profile.relStatus?.isEmpty == true && _currentPage == 5)) {
      validResult = true;
    } else if ((profile.smoke == null && _currentPage == 6) ||
        (profile.smoke?.isEmpty == true && _currentPage == 6)) {
      validResult = true;
    } else if ((profile.drink == null && _currentPage == 7) ||
        (profile.drink?.isEmpty == true && _currentPage == 7)) {
      validResult = true;
    }
    //  else if ((profile.music == null && _currentPage == 10) ||
    //     (profile.music?.isEmpty == true && _currentPage == 10)) {
    //   validResult = true;
    // }
    else if ((profile.search == null && _currentPage == 11) ||
        (profile.search?.isEmpty == true && _currentPage == 11)) {
      validResult = true;
    } else if ((profile.dateGender == null && _currentPage == 12) ||
        (profile.dateGender?.isEmpty == true && _currentPage == 12)) {
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
      case 9:
        return step10(profile);
      case 10:
        return step11(profile);
      case 11:
        return step12(profile);
      case 12:
        return step13(profile);
      case 13:
        return step14(profile);
      default:
        return step1(profile);
    }
  }

  Widget _visibleProfilePage() {
    ProfileModel profile = context.read<ProfileBloc>().state.profile;
    switch (_currentPage) {
      case 1:
        return visibleStep2(profile);
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
        return visibleStep7(profile);
      default:
        return const SizedBox(
          height: 0,
        );
    }
  }

  void createProfile() async {
    try {
      User? authedUser = FirebaseAuth.instance.currentUser;
      ProfileModel profile = context.read<ProfileBloc>().state.profile;

      if (authedUser != null) {
        context.loaderOverlay.show();
        if (profile.medias == null) {
          for (int i = 0; i < 6; i++) {
            Media temp = Media(
              index: i,
              type: '',
              media: '',
              thumbnail: '',
              duration: '',
            );
            medias.add(temp);
            context
                .read<ProfileBloc>()
                .add(ProfileUpdated(profile.copyWith(medias: medias)));
          }
        } else {
          for (var i = 0; i < profile.medias!.length; i++) {
            if (profile.medias![i].type != "") {
              Media temp =
                  await uploadMedia(authedUser.uid, profile.medias![i]);
              profile.medias![i] = temp;
            }
          }
        }
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
          } else if (profileState.status == ProfileStatus.created) {
            context.loaderOverlay.hide();
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
                                    count: 14, current: _currentPage + 1),
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
                            if (_currentPage >= 14) {
                              _currentPage = 13;
                              // createProfile();
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
    return GendersChoose(
      gender: profile.gender,
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(gender: value)));
      },
    );
  }

  Widget visibleStep2(ProfileModel profile) {
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

  Widget step3(ProfileModel profile) {
    return BirthdayChoose(
      birthday: profile.birthday ?? DateTime.now(),
      onChange: (DateTime? value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(birthday: value)));
      },
    );
  }

  Widget visibleStep3(ProfileModel profile) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      value: profile.birthdayVisibility ?? false,
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.secondary,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdated(profile.copyWith(birthdayVisibility: value)));
        });
      },
      title: const Text("Visible on my profile"),
    );
  }

  Widget step4(ProfileModel profile) {
    return HeightInput(
      height: profile.height ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(height: value)));
      },
    );
  }

  Widget visibleStep4(ProfileModel profile) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      value: profile.heightVisibility ?? false,
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.secondary,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdated(profile.copyWith(heightVisibility: value)));
        });
      },
      title: const Text("Visible on my profile"),
    );
  }

  Widget step5(ProfileModel profile) {
    return HomeTownInput(
      town: profile.town ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(town: value)));
      },
    );
  }

  Widget visibleStep5(ProfileModel profile) {
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

  Widget step6(ProfileModel profile) {
    return RelStatus(
      relStatus: profile.relStatus,
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(relStatus: value)));
      },
    );
  }

  Widget visibleStep6(ProfileModel profile) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      value: profile.relStatusVisibility ?? false,
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.secondary,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          context.read<ProfileBloc>().add(
              ProfileUpdated(profile.copyWith(relStatusVisibility: value)));
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
    return const ProfilePhotos();
  }

  Widget step10(ProfileModel profile) {
    return BioInput(
      bio: profile.bio ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(bio: value)));
      },
    );
  }

  Widget step11(ProfileModel profile) {
    return MusicChoose(
      music: profile.music ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(music: value)));
      },
    );
  }

  Widget step12(ProfileModel profile) {
    return SearchChoose(
      search: profile.search ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(search: value)));
      },
    );
  }

  Widget step13(ProfileModel profile) {
    return DateGenderChoose(
      dateGender: profile.dateGender ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(dateGender: value)));
      },
    );
  }

  Widget step14(ProfileModel profile) {
    return BioInput(
      bio: profile.distance ?? "",
      onChange: (value) {
        context
            .read<ProfileBloc>()
            .add(ProfileUpdated(profile.copyWith(distance: value)));
      },
    );
  }
}
