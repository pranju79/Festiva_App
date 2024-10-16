import 'package:event_orientation_app/modules/Admin/Admin_Login_Register/presentation/bloc/admin_register/admin_register_bloc.dart';
import 'package:event_orientation_app/modules/Admin/admin_login_register/data/models/admin_model.dart';
import 'package:event_orientation_app/utils/common/app_input_validations.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminRegisterForm extends StatefulWidget {
  const AdminRegisterForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.gradientColors,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final List<Color> gradientColors;

  @override
  State<AdminRegisterForm> createState() => _AdminRegisterFormState();
}

class _AdminRegisterFormState extends State<AdminRegisterForm> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        children: [
          TextFormField(
            controller:
                BlocProvider.of<AdminRegisterBloc>(context).nameController,
            decoration: InputDecoration(
              labelText: "Name",
              icon: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: widget.gradientColors,
                  ).createShader(bounds);
                },
                child: const Icon(TTIcons.profileRounded),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => Validations.nameValidation(value),
          ),
          UIHelpers.verticalSpaceMedium,
          TextFormField(
            controller:
                BlocProvider.of<AdminRegisterBloc>(context).emailController,
            decoration: InputDecoration(
              labelText: "Email",
              icon: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: widget.gradientColors,
                  ).createShader(bounds);
                },
                child: const Icon(TTIcons.mail),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => Validations.validateEmail(value),
          ),
          UIHelpers.verticalSpaceMedium,
          TextFormField(
            controller:
                BlocProvider.of<AdminRegisterBloc>(context).mobilenoController,
            decoration: InputDecoration(
              labelText: "Mobile No",
              icon: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: widget.gradientColors,
                  ).createShader(bounds);
                },
                child: const Icon(TTIcons.mobileRounded),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => Validations.mobileValidation(value),
          ),
          UIHelpers.verticalSpaceMedium,
          TextFormField(
            controller:
                BlocProvider.of<AdminRegisterBloc>(context).passwordController,
            decoration: InputDecoration(
              labelText: "Password",
              icon: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: widget.gradientColors,
                  ).createShader(bounds);
                },
                child: const Icon(TTIcons.pass),
              ),
              suffixIcon: IconButton(
                icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.gradientColors,
                    ).createShader(bounds);
                  },
                  child: Icon(
                    _isPasswordVisible
                        ? TTIcons.visibility
                        : TTIcons.visibility_off,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            obscureText: !_isPasswordVisible,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => Validations.passwordValidation(value),
          ),
          UIHelpers.verticalSpaceMedium,
          TextFormField(
            controller: BlocProvider.of<AdminRegisterBloc>(context)
                .confirmPassController,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              icon: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: widget.gradientColors,
                  ).createShader(bounds);
                },
                child: const Icon(TTIcons.pass),
              ),
              suffixIcon: IconButton(
                icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.gradientColors,
                    ).createShader(bounds);
                  },
                  child: Icon(
                    _isPasswordVisible
                        ? TTIcons.visibility
                        : TTIcons.visibility_off,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            obscureText: !_isPasswordVisible,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              final password = BlocProvider.of<AdminRegisterBloc>(context)
                  .passwordController
                  .text;
              if (value == null || value.isEmpty) {
                return "Please enter confirm password";
              } else if (value != password) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          UIHelpers.verticalSpaceLargePlus,
          SizedBox(
            width: 350,
            height: 40,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.gradientColors,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.transparent),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (widget._formKey.currentState!.validate()) {
                      BlocProvider.of<AdminRegisterBloc>(context)
                          .add(OnRegisterEvent(
                              admin: AdminModel(
                        name: BlocProvider.of<AdminRegisterBloc>(context)
                            .nameController
                            .text,
                        email: BlocProvider.of<AdminRegisterBloc>(context)
                            .emailController
                            .text,
                        mobileno: BlocProvider.of<AdminRegisterBloc>(context)
                            .mobilenoController
                            .text,
                        password: BlocProvider.of<AdminRegisterBloc>(context)
                            .passwordController
                            .text,
                        confirmPassword:
                            BlocProvider.of<AdminRegisterBloc>(context)
                                .confirmPassController
                                .text,
                      )));
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TTypography.textWhite24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          UIHelpers.verticalSpaceMedium,
        ],
      ),
    );
  }
}
