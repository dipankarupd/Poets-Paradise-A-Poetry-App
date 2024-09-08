import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/config/routes.dart';
import 'package:poets_paradise/cores/init_dependancy.dart';
import 'package:poets_paradise/cores/onboard/pages/onboarding_page.dart';
import 'package:poets_paradise/cores/splash/splash_screen.dart';
import 'package:poets_paradise/cores/theme/theme.dart';
import 'package:poets_paradise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:poets_paradise/features/auth/presentation/page/sign_in_page.dart';
import 'package:poets_paradise/features/auth/presentation/page/sign_up_page.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/page/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependancies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(create: (_) => serviceLocator<PoetryBloc>()),
        //BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightThemeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.initial,
      routes: {
        AppRoute.initial: (context) => const SplashScreen(),
        AppRoute.onboarding: (context) => const OnboardingPage(),
        AppRoute.signin: (context) => const SignInPage(),
        AppRoute.signup: (context) => const SignUpPage(),
        AppRoute.landing: (context) => LandingPage(),
        // AppRoute.newPage: (context) => const ProfilePage(),
      },
    );
  }
}
