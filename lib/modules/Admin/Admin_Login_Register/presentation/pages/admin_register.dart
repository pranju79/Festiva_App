import 'package:event_orientation_app/modules/Admin/Admin_Login_Register/presentation/bloc/admin_register/admin_register_bloc.dart';
import 'package:event_orientation_app/modules/Admin/Admin_Login_Register/presentation/widgets/admin_register_form.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({super.key});

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Color> gradientColors = [
    Colors.blue,
    Colors.purple,
    Colors.pink,
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminRegisterBloc(),
      child: BlocConsumer<AdminRegisterBloc, AdminRegisterState>(
        listener: (context, state) {
          if (state is AdminRegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.message,
              style: TTypography.textWhite18,
            )));
          } else if (state is AdminRegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.error,
              style: TTypography.textWhite18,
            )));
          }
          return;
        },
        builder: (context, state) {
          if (state is AdminRegisterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdminRegisterSuccess) {
            BlocProvider.of<AdminRegisterBloc>(context).nameController.clear();
            BlocProvider.of<AdminRegisterBloc>(context).emailController.clear();
            BlocProvider.of<AdminRegisterBloc>(context)
                .mobilenoController
                .clear();
            BlocProvider.of<AdminRegisterBloc>(context)
                .passwordController
                .clear();
            BlocProvider.of<AdminRegisterBloc>(context)
                .confirmPassController
                .clear();
          }
          return Scaffold(
            appBar: AppBar(
              foregroundColor: TTColors.white,
              title: const Text(
                'Admin Registration',
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      gradientColors[0].withOpacity(0.1),
                      gradientColors[1].withOpacity(0.1),
                      gradientColors[2].withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.purpleAccent,
                          backgroundImage: NetworkImage(
                              'https://miro.medium.com/v2/resize:fit:512/1*7tlP1ph61ompULJdycVJlQ.png'),
                        ),
                      ),
                      UIHelpers.verticalSpaceMedium,
                      AdminRegisterForm(
                        formKey: _formKey,
                        gradientColors: gradientColors,
                      ),
                    ],
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
