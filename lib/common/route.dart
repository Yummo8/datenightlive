import 'package:flutter/widgets.dart';
import 'package:DNL/core/blocs/auth/auth_bloc.dart';
import 'package:DNL/core/blocs/profile/profile_bloc.dart';
import 'package:DNL/view/splash/splash_page.dart';
import 'package:DNL/view/welcome/welcome_done_page.dart';
import 'package:DNL/view/welcome/welcome_page.dart';
import 'package:DNL/view/welcome/welcome_profile_page.dart';

enum AuthRouteState {
  initializing,
  creatingProfile,
  authenticated,
  unauthenticated,
}

List<Page<dynamic>> onGenerateAppViewPages(
  AuthRouteState state,
  List<Page<dynamic>> pages,
) {
  if (state == AuthRouteState.initializing) {
    return [SplashPage.page()];
  } else if (state == AuthRouteState.authenticated) {
    return [WelcomeDonePage.page()];
  } else if (state == AuthRouteState.creatingProfile) {
    return [WelcomeProfilePage.page()];
  } else {
    return [WelcomePage.page(), WelcomePage.page()];
  }
}

AuthRouteState getRouteState(
  AuthState authState,
  ProfileState profileState,
) {
  if (authState is AppInitializing ||
      (authState is Authenticated &&
          profileState.status == ProfileStatus.loading)) {
    return AuthRouteState.initializing;
  } else if (authState is Authenticated &&
      (profileState.status == ProfileStatus.success ||
          profileState.status == ProfileStatus.updateLoading)) {
    return AuthRouteState.authenticated;
  } else if (authState is Authenticated &&
      (profileState.status == ProfileStatus.notCreated ||
          profileState.status == ProfileStatus.created ||
          profileState.status == ProfileStatus.createLoading)) {
    return AuthRouteState.creatingProfile;
  } else {
    return AuthRouteState.unauthenticated;
  }
}
