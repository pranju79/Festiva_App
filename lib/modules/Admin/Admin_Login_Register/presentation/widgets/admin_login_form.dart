import 'package:event_orientation_app/modules/Admin/Admin_Login_Register/data/models/admin_model.dart';
import 'package:event_orientation_app/modules/Admin/Admin_Login_Register/presentation/bloc/admin_login/admin_login_bloc.dart';
import 'package:event_orientation_app/utils/common/app_input_validations.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginForm extends StatefulWidget {
  const AdminLoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.gradientColors,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final List<Color> gradientColors;

  @override
  State<AdminLoginForm> createState() => _AdminLoginFormState();
}

class _AdminLoginFormState extends State<AdminLoginForm> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        children: [
          TextFormField(
            controller:
                BlocProvider.of<AdminLoginBloc>(context).emailController,
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
                BlocProvider.of<AdminLoginBloc>(context).passwordController,
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
          UIHelpers.verticalSpaceExtraLarge,
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
                    BlocProvider.of<AdminLoginBloc>(context).add(OnLoginEvent(
                      admin: AdminModel(
                        email: BlocProvider.of<AdminLoginBloc>(context)
                            .emailController
                            .text,
                        name: '',
                        mobileno: '',
                        password: BlocProvider.of<AdminLoginBloc>(context)
                            .passwordController
                            .text,
                        confirmPassword: '',
                      ),
                    ));
                  },
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TTypography.textWhite26,
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
