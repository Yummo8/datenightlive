import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:DNL/common/values/colors.dart';
import 'package:DNL/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:DNL/core/repositories/auth_repository.dart';
import 'package:flutter/scheduler.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:DNL/common/values/theme.dart';
import 'package:DNL/common/route.dart';
import 'package:DNL/core/repositories/profile_repository.dart';
import 'package:DNL/core/blocs/auth/auth_bloc.dart';
import 'package:DNL/core/blocs/profile/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "date-night-live-2023",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthRepository();
  final profileRepository = ProfileRepository();

  runApp(DevicePreview(
      enabled: false,
      builder: (context) => MyApp(
            authenticationRepository: authenticationRepository,
            profileRepository: profileRepository,
          )));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authenticationRepository;
  final ProfileRepository _profileRepository;

  const MyApp({
    super.key,
    required AuthRepository authenticationRepository,
    required ProfileRepository profileRepository,
  })  : _authenticationRepository = authenticationRepository,
        _profileRepository = profileRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthBloc>(
            create: (_) =>
                AuthBloc(authenticationRepository: _authenticationRepository),
          ),
          BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(
              profileRepository: _profileRepository,
            ),
          ),
        ], child: const OverlaySupport.global(child: AppView())));
  }
}

class AppView extends StatelessWidget implements TickerProvider {
  const AppView({super.key});

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        title: "DNL",
        home: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  User? authedUser = FirebaseAuth.instance.currentUser;
                  context
                      .read<ProfileBloc>()
                      .add(ProfileLoadRequested(authedUser!.uid));
                } else if (state is UnAuthenticated) {
                  context.read<ProfileBloc>().add(ProfileSignoutRequested());
                  if (state.error != null && state.error != "") {
                    toast(state.error!);
                  }
                }
              },
            )
          ],
          child: LoaderOverlay(
              useDefaultLoading: false,
              overlayWidget: const Center(
                child: SpinKitCubeGrid(
                  color: ThemeColors.primary,
                  size: 50.0,
                ),
              ),
              child: FlowBuilder<AuthRouteState>(
                state: getRouteState(
                  context.select((AuthBloc bloc) => bloc.state),
                  context.select((ProfileBloc bloc) => bloc.state),
                ),
                onGeneratePages: onGenerateAppViewPages,
              )),
        ));
  }
}
