import 'package:event_orientation_app/modules/Admin/Admin_Login_Register/presentation/bloc/admin_login/admin_login_bloc.dart';
import 'package:event_orientation_app/modules/Admin/Admin_Login_Register/presentation/widgets/admin_login_form.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Color> gradientColors = [
    Colors.blue,
    Colors.purple,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminLoginBloc(),
      child: BlocConsumer<AdminLoginBloc, AdminLoginState>(
        listener: (context, state) {
          if (state is AdminLoginSuccess) {
            Navigator.pushNamed(context, '/adminhome', arguments: state.email);
          } else if (state is AdminLoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: TTypography.textWhite18,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminLoginLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdminLoginSuccess) {
            BlocProvider.of<AdminLoginBloc>(context).emailController.clear();
            BlocProvider.of<AdminLoginBloc>(context).passwordController.clear();
          }

          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: TTColors.gradientColor,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 40,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: TTColors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onLongPress: () =>
                                      Navigator.pushNamed(context, '/login'),
                                  child: const CircleAvatar(
                                    backgroundImage: AssetImage('assets/2.png'),
                                    radius: 60,
                                  ),
                                ),
                                UIHelpers.verticalSpaceMedium,
                                Column(
                                  children: [
                                    ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: gradientColors,
                                        ).createShader(bounds);
                                      },
                                      child: const Text(
                                        "Admin Login",
                                        style: TTypography.textBlue30Bold,
                                      ),
                                    ),
                                    UIHelpers.verticalSpaceLarge,
                                    AdminLoginForm(
                                        formKey: _formKey,
                                        gradientColors: gradientColors),
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
            ),
          );
        },
      ),
    );
  }
}
