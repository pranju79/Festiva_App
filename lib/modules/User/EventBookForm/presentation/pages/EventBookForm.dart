import 'package:event_orientation_app/modules/User/EventBookForm/data/models/eventbook_model.dart';
import 'package:event_orientation_app/modules/User/EventBookForm/presentation/bloc/eventbook_bloc.dart';
import 'package:event_orientation_app/modules/User/Home/presentation/views/home_mobile_view.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/pages/Loginpage.dart';
import 'package:event_orientation_app/utils/common/app_input_validations.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventBookForm extends StatefulWidget {
  String? eventname;
  String? themename;
  final String email;
  EventBookForm(
      {super.key,
      required this.eventname,
      required this.themename,
      required this.email});

  @override
  State<EventBookForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventBookForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Color> gradientColors = [Colors.blue, Colors.purple, Colors.pink];
  String? _selectedValue;
  String? EventName;
  String? Eventtheme;
  String? packages;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventbookBloc(),
      child: BlocConsumer<EventbookBloc, EventbookState>(
        listener: (context, state) {
          if (state is EventbookSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
              "Event Booking Successful",
              style: TTypography.textBlue22Bold,
            )));
          } else if (state is EventbookError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.error,
              style: TTypography.textBlue22Bold,
            )));
          }
          return;
        },
        builder: (context, state) {
          if (state is EventbookLoadiing) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventbookSuccess) {
            BlocProvider.of<EventbookBloc>(context).nameController.clear();
            BlocProvider.of<EventbookBloc>(context).mobileController.clear();
            BlocProvider.of<EventbookBloc>(context)
                .dateofeventController
                .clear();
            BlocProvider.of<EventbookBloc>(context).guestController.clear();
            BlocProvider.of<EventbookBloc>(context).locationController.clear();
          }
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(gradient: TTColors.gradientColor),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      color: TTColors.white,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    // const Text(
                                    //   'Event App',
                                    //   style: TTypography.textBlack22Bold,
                                    // ),
                                    UIHelpers.verticalSpaceMedium,
                                    Column(
                                      children: [
                                        const Text(
                                          "Book Event",
                                          style: TTypography.textBlue30Bold,
                                        ),
                                        UIHelpers.verticalSpaceLarge,
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                  controller: BlocProvider.of<
                                                              EventbookBloc>(
                                                          context)
                                                      .nameController,
                                                  decoration: InputDecoration(
                                                    labelText: "Full Name",
                                                    icon: ShaderMask(
                                                      blendMode:
                                                          BlendMode.srcIn,
                                                      shaderCallback:
                                                          (Rect bounds) {
                                                        return LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors:
                                                              gradientColors,
                                                        ).createShader(bounds);
                                                      },
                                                      child: const Icon(TTIcons
                                                          .profileRounded),
                                                    ),
                                                  ),
                                                  validator: (value) =>
                                                      Validations
                                                          .nameValidation(
                                                              value)),
                                              UIHelpers.verticalSpaceMedium,
                                              TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      TextEditingController(
                                                          text: widget.email),
                                                  decoration: InputDecoration(
                                                    labelText: "Email ID",
                                                    icon: ShaderMask(
                                                      blendMode:
                                                          BlendMode.srcIn,
                                                      shaderCallback:
                                                          (Rect bounds) {
                                                        return LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors:
                                                              gradientColors,
                                                        ).createShader(bounds);
                                                      },
                                                      child: const Icon(
                                                          TTIcons.mail),
                                                    ),
                                                  ),
                                                  validator: (value) =>
                                                      Validations.validateEmail(
                                                          value)),
                                              UIHelpers.verticalSpaceMedium,
                                              TextFormField(
                                                  controller: BlocProvider.of<
                                                              EventbookBloc>(
                                                          context)
                                                      .mobileController,
                                                  decoration: InputDecoration(
                                                      labelText: "Mobile No",
                                                      icon: ShaderMask(
                                                          blendMode:
                                                              BlendMode.srcIn,
                                                          shaderCallback:
                                                              (Rect bounds) {
                                                            return LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors:
                                                                  gradientColors,
                                                            ).createShader(
                                                                bounds);
                                                          },
                                                          child: const Icon(TTIcons
                                                              .mobileRounded))),
                                                  validator: (value) =>
                                                      Validations
                                                          .mobileValidation(
                                                              value)),
                                              UIHelpers.verticalSpaceMedium,
                                              TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      TextEditingController(
                                                          text:
                                                              widget.eventname),
                                                  decoration: InputDecoration(
                                                      labelText: "Event Name",
                                                      icon: ShaderMask(
                                                          blendMode:
                                                              BlendMode.srcIn,
                                                          shaderCallback:
                                                              (Rect bounds) {
                                                            return LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors:
                                                                  gradientColors,
                                                            ).createShader(
                                                                bounds);
                                                          },
                                                          child: const Icon(
                                                              TTIcons
                                                                  .add_event))),
                                                  validator: (value) =>
                                                      Validations
                                                          .nameValidation(
                                                              value)),

                                              UIHelpers.verticalSpaceMedium,
                                              TextFormField(
                                                  readOnly: true,
                                                  controller:
                                                      TextEditingController(
                                                          text:
                                                              widget.themename),
                                                  decoration: InputDecoration(
                                                      labelText: "Event Theme",
                                                      icon: ShaderMask(
                                                          blendMode:
                                                              BlendMode.srcIn,
                                                          shaderCallback:
                                                              (Rect bounds) {
                                                            return LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors:
                                                                  gradientColors,
                                                            ).createShader(
                                                                bounds);
                                                          },
                                                          child: const Icon(
                                                              TTIcons
                                                                  .Themeselect))),
                                                  validator: (value) =>
                                                      Validations
                                                          .nameValidation(
                                                              value)),
                                              UIHelpers.verticalSpaceMedium,
                                              TextFormField(
                                                controller: BlocProvider.of<
                                                        EventbookBloc>(context)
                                                    .dateofeventController,
                                                decoration: InputDecoration(
                                                    labelText: "Date Of Event",
                                                    icon: ShaderMask(
                                                        blendMode:
                                                            BlendMode.srcIn,
                                                        shaderCallback:
                                                            (Rect bounds) {
                                                          return LinearGradient(
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            colors:
                                                                gradientColors,
                                                          ).createShader(
                                                              bounds);
                                                        },
                                                        child: const Icon(
                                                            TTIcons.calender))),
                                                onTap: () async {
                                                  DateTime? pickeddate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime(2100));
                                                  if (pickeddate != null) {
                                                    setState(() {
                                                      BlocProvider.of<
                                                                  EventbookBloc>(
                                                              context)
                                                          .dateofeventController
                                                          .text = DateFormat(
                                                              "yyyy-MM-dd")
                                                          .format(pickeddate);
                                                    });
                                                  }
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'please enter date of birth';
                                                  }
                                                  return null;
                                                },
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                              ),
                                              UIHelpers.verticalSpaceMedium,
                                              TextFormField(
                                                controller: BlocProvider.of<
                                                        EventbookBloc>(context)
                                                    .locationController,
                                                decoration: InputDecoration(
                                                    labelText: "Location ",
                                                    icon: ShaderMask(
                                                        blendMode:
                                                            BlendMode.srcIn,
                                                        shaderCallback:
                                                            (Rect bounds) {
                                                          return LinearGradient(
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            colors:
                                                                gradientColors,
                                                          ).createShader(
                                                              bounds);
                                                        },
                                                        child: const Icon(
                                                            TTIcons.location))),
                                                validator: (value) =>
                                                    Validations.requireField(
                                                        value),
                                              ),
                                              UIHelpers.verticalSpaceMedium,
                                              TextFormField(
                                                controller: BlocProvider.of<
                                                        EventbookBloc>(context)
                                                    .guestController,
                                                decoration: InputDecoration(
                                                    labelText: "No Of Geust",
                                                    icon: ShaderMask(
                                                        blendMode:
                                                            BlendMode.srcIn,
                                                        shaderCallback:
                                                            (Rect bounds) {
                                                          return LinearGradient(
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            colors:
                                                                gradientColors,
                                                          ).createShader(
                                                              bounds);
                                                        },
                                                        child: const Icon(
                                                            TTIcons.persons))),
                                                validator: (value) =>
                                                    Validations.requireField(
                                                        value),
                                              ),
                                              UIHelpers.verticalSpaceMedium,
                                              Column(
                                                children: <Widget>[
                                                  const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Select Package',
                                                        style: TTypography
                                                            .textBlack24Bold,
                                                      ),
                                                    ],
                                                  ),
                                                  RadioListTile(
                                                    title: const Text(
                                                        '10,000 -50,000 [For 100 seating]'),
                                                    value:
                                                        '10,000 -50,000 [For 100 seating]',
                                                    groupValue: _selectedValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: const Text(
                                                        '50,000 -1,00,000 [For 200 seating]'),
                                                    value:
                                                        '50,000 -1,00,000 [For 200 seating]',
                                                    groupValue: _selectedValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue = value;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: const Text(
                                                        '1,00,000- 1,50,000 [For 300 seating]'),
                                                    value:
                                                        '1,00,000- 1,50,000 [For 300 seating]',
                                                    groupValue: _selectedValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: const Text(
                                                        '2,00,000- 3,50,000 [For 400 seating]'),
                                                    value:
                                                        "2,00,000- 3,50,000 [For 400 seating]",
                                                    groupValue: _selectedValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue = value;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: const Text(
                                                        '3,50,000-5,00,000 [For 500 seating]'),
                                                    value:
                                                        "3,50,000-5,00,000 [For 500 seating]",
                                                    groupValue: _selectedValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue = value;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: const Text(
                                                        '5,00,000-10,00,000 [For 1000 seating]'),
                                                    value:
                                                        "5,00,000-10,00,000 [For 1000 seating]",
                                                    groupValue: _selectedValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue = value;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: const Text('None'),
                                                    value: "None",
                                                    groupValue: _selectedValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue = value;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              UIHelpers.verticalSpaceLarge,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 180,
                                                    height: 50,
                                                    child: ElevatedButton(
                                                      style: const ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStatePropertyAll(
                                                                Colors.purple),
                                                      ),
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          BlocProvider.of<EventbookBloc>(context).add(OnSubmitEvent(
                                                              book: Eventbook(
                                                                  name: BlocProvider.of<EventbookBloc>(context)
                                                                      .nameController
                                                                      .text,
                                                                  email: widget
                                                                      .email,
                                                                  mobile: BlocProvider.of<EventbookBloc>(context)
                                                                      .mobileController
                                                                      .text,
                                                                  guest: BlocProvider.of<EventbookBloc>(context)
                                                                      .guestController
                                                                      .text,
                                                                  location: BlocProvider.of<EventbookBloc>(context)
                                                                      .locationController
                                                                      .text,
                                                                  dateofevent:
                                                                      BlocProvider.of<EventbookBloc>(context)
                                                                          .dateofeventController
                                                                          .text,
                                                                  eventTheme:
                                                                      '${widget.themename}',
                                                                  eventname:
                                                                      '${widget.eventname}',
                                                                  packages:
                                                                      _selectedValue ??
                                                                          '',
                                                                  status: 'Pending')));
                                                        }
                                                      },
                                                      child: const Text(
                                                        "Submit",
                                                        style: TTypography
                                                            .textWhite26,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
