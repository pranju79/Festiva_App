import 'package:event_orientation_app/modules/User/UserRegister_Screen/data/models/user_model.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/bloc/user_register/user_register_bloc.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/bloc/user_register/user_register_event.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/pages/Loginpage.dart';
import 'package:event_orientation_app/utils/common/app_input_validations.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _gender;
  final List<Color> gradientColors = [Colors.blue, Colors.purple, Colors.pink];
  bool _obscureText = true;
  bool _obscureText1 = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserRegisterBloc(),
      child: BlocConsumer<UserRegisterBloc, UserRegisterState>(
        listener: (context, state) {
          if (state is UserRegisterSuccess) {
            Navigator.pushNamed(context, '/login');
          } else if (state is UserRegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.error,
              style: TTypography.textBlue22Bold,
            )));
          }
          return;
        },
        builder: (context, state) {
          if (state is UserRegisterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserRegisterSuccess) {
            BlocProvider.of<UserRegisterBloc>(context).nameController.clear();
            BlocProvider.of<UserRegisterBloc>(context).emailController.clear();
            BlocProvider.of<UserRegisterBloc>(context).mobileController.clear();
            BlocProvider.of<UserRegisterBloc>(context).GenderController.clear();
            BlocProvider.of<UserRegisterBloc>(context).PassController.clear();
            BlocProvider.of<UserRegisterBloc>(context)
                .ConformPassController
                .clear();
          }
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(gradient: TTColors.gradientColor),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: TTColors.white,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage('assets/2.png'),
                                radius: 60,
                              ),
                              UIHelpers.verticalSpaceMedium,
                              Column(
                                children: [
                                  const Text(
                                    "Create New Account",
                                    style: TTypography.textBlue30Bold,
                                  ),
                                  UIHelpers.verticalSpaceLarge,
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller:
                                              BlocProvider.of<UserRegisterBloc>(
                                                      context)
                                                  .nameController,
                                          decoration: InputDecoration(
                                            labelText: "Full Name",
                                            icon: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: gradientColors,
                                                ).createShader(bounds);
                                              },
                                              child:
                                                  Icon(TTIcons.profileRounded),
                                            ),
                                          ),
                                          validator: (value) =>
                                              Validations.nameValidation(value),
                                        ),
                                        UIHelpers.verticalSpaceMedium,
                                        TextFormField(
                                          controller:
                                              BlocProvider.of<UserRegisterBloc>(
                                                      context)
                                                  .emailController,
                                          decoration: InputDecoration(
                                            labelText: "Email Id",
                                            icon: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: gradientColors,
                                                ).createShader(bounds);
                                              },
                                              child: Icon(TTIcons.mail),
                                            ),
                                          ),
                                          validator: (value) =>
                                              Validations.validateEmail(value),
                                        ),
                                        UIHelpers.verticalSpaceMedium,
                                        TextFormField(
                                          controller:
                                              BlocProvider.of<UserRegisterBloc>(
                                                      context)
                                                  .mobileController,
                                          decoration: InputDecoration(
                                              labelText: "Mobile No",
                                              icon: ShaderMask(
                                                  blendMode: BlendMode.srcIn,
                                                  shaderCallback:
                                                      (Rect bounds) {
                                                    return LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: gradientColors,
                                                    ).createShader(bounds);
                                                  },
                                                  child: Icon(
                                                      TTIcons.mobileRounded))),
                                          validator: (value) =>
                                              Validations.mobileValidation(
                                                  value),
                                        ),
                                        UIHelpers.verticalSpaceMedium,
                                        // TextFormField(
                                        //     controller: BlocProvider.of<
                                        //             UserRegisterBloc>(context)
                                        //         .GenderController,
                                        //     decoration: InputDecoration(
                                        //         labelText: "Gender",
                                        //         icon: ShaderMask(
                                        //             blendMode: BlendMode.srcIn,
                                        //             shaderCallback:
                                        //                 (Rect bounds) {
                                        //               return LinearGradient(
                                        //                 begin:
                                        //                     Alignment.topLeft,
                                        //                 end: Alignment
                                        //                     .bottomRight,
                                        //                 colors: gradientColors,
                                        //               ).createShader(bounds);
                                        //             },
                                        //             child: const Icon(TTIcons
                                        //                 .profileRounded))),
                                        //     validator: (value) =>
                                        //         Validations.requireField(
                                        //             value)),
                                        DropdownButtonFormField(
                                          items: const [
                                            DropdownMenuItem(
                                              value: 'Female',
                                              child: Text('Female'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'Male',
                                              child: Text('Male'),
                                            ),
                                          ],
                                          value: _gender,
                                          onChanged: (newvalue) {
                                            setState(() {
                                              _gender = newvalue;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Gender',
                                            labelStyle: TTypography.textBlack16,
                                            icon: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: gradientColors,
                                                ).createShader(bounds);
                                              },
                                              child: const Icon(
                                                  TTIcons.profileRounded),
                                            ),
                                          ),
                                        ),
                                        UIHelpers.verticalSpaceMedium,
                                        TextFormField(
                                          controller:
                                              BlocProvider.of<UserRegisterBloc>(
                                                      context)
                                                  .PassController,
                                          obscureText:
                                              _obscureText, // Toggles visibility
                                          decoration: InputDecoration(
                                            labelText: "Create New Password",
                                            labelStyle: TTypography.textBlack16,
                                            icon: ShaderMask(
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
                                              Validations.passwordValidation(
                                                  value),
                                        ),
                                        UIHelpers.verticalSpaceMedium,
                                        TextFormField(
                                          controller:
                                              BlocProvider.of<UserRegisterBloc>(
                                                      context)
                                                  .ConformPassController,
                                          obscureText:
                                              _obscureText1, // Toggles visibility
                                          decoration: InputDecoration(
                                            labelText: "Confirm Password",
                                            labelStyle: TTypography.textBlack16,
                                            icon: ShaderMask(
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
                                                _obscureText1
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _obscureText1 =
                                                      !_obscureText1;
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
                                                          Colors.purple),
                                                ),
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    BlocProvider.of<
                                                                UserRegisterBloc>(
                                                            context)
                                                        .add(OnSubmitEvent(
                                                            user: User(
                                                      name: BlocProvider.of<
                                                                  UserRegisterBloc>(
                                                              context)
                                                          .nameController
                                                          .text,
                                                      email: BlocProvider.of<
                                                                  UserRegisterBloc>(
                                                              context)
                                                          .emailController
                                                          .text,
                                                      mobile: BlocProvider.of<
                                                                  UserRegisterBloc>(
                                                              context)
                                                          .mobileController
                                                          .text,
                                                      gender: '$_gender',
                                                      password: BlocProvider.of<
                                                                  UserRegisterBloc>(
                                                              context)
                                                          .PassController
                                                          .text,
                                                      conformPass: BlocProvider
                                                              .of<UserRegisterBloc>(
                                                                  context)
                                                          .ConformPassController
                                                          .text,
                                                    )));
                                                  }
                                                },
                                                child: const Text(
                                                  "Register",
                                                  style:
                                                      TTypography.textWhite26,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        UIHelpers.verticalSpaceLarge,
                                        const Text(
                                          "If you have an account ",
                                          style: TTypography.textBlack14,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/login');
                                          },
                                          child: const Text("Click Here"),
                                        )
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
