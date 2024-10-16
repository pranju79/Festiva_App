import 'package:event_orientation_app/modules/User/UserRegister_Screen/data/models/user_model.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/bloc/login/login_bloc.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/bloc/login/login_event.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/bloc/login/login_state.dart';
import 'package:event_orientation_app/utils/common/app_input_validations.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Color> gradientColors = [
    Colors.blue,
    Colors.purple,
    Colors.pink,
  ];
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushNamed(context, '/userhome', arguments: state.email);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: TTypography.textBlue22Bold,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            body: Container(
              height: double.infinity, // Set the height to double.infinity here
              decoration: const BoxDecoration(
                gradient: TTColors.gradientColor,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: TTColors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onLongPress: () =>
                                    Navigator.pushNamed(context, '/adminlogin'),
                                child: const CircleAvatar(
                                  backgroundImage: AssetImage('assets/2.png'),
                                  radius: 60,
                                ),
                              ),
                              UIHelpers.verticalSpaceMedium,
                              Column(
                                children: [
                                  const Text(
                                    "Login to Account",
                                    style: TTypography.textBlue28Bold,
                                  ),
                                  UIHelpers.horizontalSpaceExtraLarge,
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        UIHelpers.verticalSpaceSmall,
                                        TextFormField(
                                          controller:
                                              BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .emailController,
                                          decoration: InputDecoration(
                                            labelText: "Email Id",
                                            labelStyle: TTypography.textBlack16,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            prefixIcon: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: gradientColors,
                                                ).createShader(bounds);
                                              },
                                              child: const Icon(TTIcons.mail),
                                            ),
                                          ),
                                          validator: (value) =>
                                              Validations.requireField(value),
                                        ),
                                        UIHelpers.verticalSpaceLarge,
                                        TextFormField(
                                          controller:
                                              BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .passController,
                                          obscureText:
                                              _obscureText, // Toggles visibility
                                          decoration: InputDecoration(
                                            labelText: "Password",
                                            labelStyle: TTypography.textBlack16,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            prefixIcon: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: gradientColors,
                                                ).createShader(bounds);
                                              },
                                              child: const Icon(TTIcons.pass),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscureText
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                            ),
                                          ),
                                          validator: (value) =>
                                              Validations.requireField(value),
                                        ),
                                        UIHelpers.verticalSpaceLarge,
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: 350,
                                              height: 50,
                                              child: ElevatedButton(
                                                style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          TTColors.purple),
                                                ),
                                                onPressed: () {
                                                  BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .add(LoginButtonPressed(
                                                    users: User(
                                                      email: BlocProvider.of<
                                                                  LoginBloc>(
                                                              context)
                                                          .emailController
                                                          .text,
                                                      name: '',
                                                      mobile: '',
                                                      gender: '',
                                                      password: BlocProvider.of<
                                                                  LoginBloc>(
                                                              context)
                                                          .passController
                                                          .text,
                                                      conformPass: '',
                                                    ),
                                                    email: '',
                                                  ));
                                                },
                                                child: const Text(
                                                  "Login",
                                                  style:
                                                      TTypography.textWhite26,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        UIHelpers.verticalSpaceLarge,
                                        const Text(
                                          "If you don't have an account",
                                          style: TTypography.textBlack14,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/register');
                                          },
                                          child: const Text("Click Here"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
