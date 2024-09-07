import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/config/routes.dart';
import 'package:poets_paradise/cores/logo/app_logo.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/cores/utils/loader.dart';
import 'package:poets_paradise/cores/utils/show_snackbar.dart';
import 'package:poets_paradise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:poets_paradise/features/auth/presentation/widget/form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showSnackbar(context, state.message);
        } else if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.landing, (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Loader();
        } else {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Column(
                          children: [
                            const AppLogo(),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Image.asset('assets/images/poetry.jpg'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Welcome aboard.\nPlease Register yourself',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: AppPallete.purpleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      AuthField(
                        hint: 'johndoe',
                        label: 'Enter the username',
                        leadingIcon: const Icon(Icons.person),
                        controller: usernameController,
                      ),
                      const SizedBox(height: 20),
                      AuthField(
                        hint: 'johndoe@gmail.com',
                        label: 'Enter the email',
                        leadingIcon: const Icon(Icons.email),
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      AuthPasswordField(
                        hint: ' more than 6 letters',
                        label: 'Enter the password',
                        leadingIcon: const Icon(Icons.lock),
                        controller: passwordController,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context
                                .read<AuthBloc>()
                                .add(SignupButtonPressedEvent(
                                  username: usernameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ));
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                          AppPallete.purpleColor,
                        )),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: AppPallete.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: RichText(
                          text: TextSpan(
                              text: 'Already have an account? ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: const [
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: AppPallete.purpleColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
