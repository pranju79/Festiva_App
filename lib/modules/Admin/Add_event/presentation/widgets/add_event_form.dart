//Pooja Kaloji

import 'dart:io';
import 'package:event_orientation_app/modules/Admin/Add_event/data/models/event_model.dart';
import 'package:event_orientation_app/modules/Admin/Add_event/presentation/bloc/add_event_bloc.dart';
import 'package:event_orientation_app/modules/Admin/Add_event/presentation/bloc/add_event_event.dart';
import 'package:event_orientation_app/modules/Admin/Add_event/presentation/bloc/add_event_state.dart';
import 'package:event_orientation_app/modules/Admin/Add_event/presentation/views/add_data.dart';
import 'package:event_orientation_app/utils/common/app_input_validations.dart';
import 'package:event_orientation_app/utils/common/custom_button.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddEventForm extends StatefulWidget {
  const AddEventForm({super.key});

  @override
  State<AddEventForm> createState() => AddEventFormState();
}

class AddEventFormState extends State<AddEventForm> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? event_date;
  String? themes;
  String? eventtype;
  File? selectedImageName;
  String? imageUrl;

  Future uploadPhoto() async {
    if (selectedImageName == null) return;
    final fileName = basename(selectedImageName!.path);
    final destination = 'files/$fileName';
    try {
      final ref = FirebaseStorage.instance.ref(destination).child('image');
      await ref.putFile(selectedImageName!);
      imageUrl = await ref.getDownloadURL();
    } catch (e) {
      print('error occured : $e');
    }
  }

  Future datepicker(context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime(3000));

    if (selectedDate == null) {
      return;
    } else {
      setState(() {
        event_date =
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
        print("Date $event_date");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEventBloc(),
      child: BlocConsumer<AddEventBloc, AddEventState>(
        listener: (context, state) {
          if (state is AddEventSucessState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                'Event Add Sucessfully!',
                style: TTypography.textGreen18Bold,
              ),
              backgroundColor: TTColors.white,
            ));
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const AddData()));
          } else if (state is AddEventErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                style: const TextStyle(
                    fontSize: 18,
                    color: TTColors.danger,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: TTColors.white,
            ));
          }
        },
        builder: (context, state) {
          if (state is AddEventLoadingState) {
            const Center(child: CircularProgressIndicator());
          } else if (state is AddEventSucessState) {
            BlocProvider.of<AddEventBloc>(context).eventtitleController.clear();
            BlocProvider.of<AddEventBloc>(context)
                .descriptionController
                .clear();
            BlocProvider.of<AddEventBloc>(context).serviceController.clear();
            BlocProvider.of<AddEventBloc>(context).packageController.clear();
            BlocProvider.of<AddEventBloc>(context).priceController.clear();
            BlocProvider.of<AddEventBloc>(context).imageurlController.clear();
          }

          return Scaffold(
            appBar: AppBar(
              foregroundColor: TTColors.white,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: TTColors.gradientColor,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: TTColors.gradientColor,
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            UIHelpers.verticalSpaceSmall,
                            const Text(
                              'EVENT INFORMATION',
                              style: TTypography.textBlue22Bold,
                            ),
                            UIHelpers.verticalSpaceLarge,
                            DropdownButtonFormField(
                              iconEnabledColor: TTColors.pink,
                              borderRadius: BorderRadius.circular(10),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Birthday Party',
                                  child: Text('Birthday Party'),
                                ),
                                DropdownMenuItem(
                                  value: 'Wedding Events',
                                  child: Text('Wedding Events'),
                                ),
                                DropdownMenuItem(
                                  value: 'Corporate Events',
                                  child: Text('Corporate Events'),
                                ),
                                DropdownMenuItem(
                                  value: 'Sports Events',
                                  child: Text('Sports Events'),
                                ),
                                DropdownMenuItem(
                                  value: 'Cultural Events',
                                  child: Text('Cultural Events'),
                                ),
                                DropdownMenuItem(
                                  value: 'Religious Events',
                                  child: Text('Religious Events'),
                                )
                              ],
                              value: eventtype,
                              onChanged: (newvalue) {
                                setState(() {
                                  eventtype = newvalue;
                                });
                              },
                              validator: (themes) =>
                                  Validations.requireField(themes),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Event Types',
                                labelStyle: TTypography.textBlack16,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .eventtitleController,
                              validator: (value) =>
                                  Validations.requireField(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: 'Event Title',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Enter Event Title',
                                prefixIcon: Icon(TTIcons.event),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .imageurlController,
                              onTap: () async {
                                final image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                setState(() {
                                  if (image != null) {
                                    BlocProvider.of<AddEventBloc>(context)
                                        .imageurlController
                                        .text = image.path;
                                    if (kIsWeb) {
                                      imageUrl = image.path;
                                    } else {
                                      selectedImageName = File(image.path);
                                      uploadPhoto();
                                    }
                                  } else {
                                    print('No image selected');
                                  }
                                });
                              },
                              validator: (value) =>
                                  Validations.requireField(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: 'Event Image',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Add Image',
                                prefixIcon: Icon(TTIcons.imageupload),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .eventDateController,
                              onTap: () {
                                setState(() {
                                  datepicker(context);
                                  BlocProvider.of<AddEventBloc>(context)
                                      .eventDateController
                                      .text = event_date!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Event Date',
                                labelStyle: TTypography.textBlack16,
                                prefixIcon: const Icon(TTIcons.calender),
                                prefixIconColor: TTColors.pink,
                              ),
                              validator: (value) =>
                                  Validations.requireField(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .descriptionController,
                              validator: (value) =>
                                  Validations.requireField(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLines: 2,
                              maxLength: 1000,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: 'Description',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Add event information',
                                prefixIcon: Icon(TTIcons.description),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .serviceController,
                              validator: (value) =>
                                  Validations.requireField(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLines: 2,
                              maxLength: 1000,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: 'Services',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Add services',
                                prefixIcon: Icon(TTIcons.services),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .priceController,
                              validator: (value) =>
                                  Validations.requireField(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: 'Price',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Eg. Rs.20,000 - Rs.2,00,000',
                                prefixIcon: Icon(TTIcons.price),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .packageController,
                              validator: (value) =>
                                  Validations.requireField(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLines: 2,
                              maxLength: 1000,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: 'Packages',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Add Packages',
                                prefixIcon: Icon(Icons.add_box),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            DropdownButtonFormField(
                              iconEnabledColor: TTColors.pink,
                              borderRadius: BorderRadius.circular(10),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Birthday Party Themes',
                                  child: Text('Birthday Party Themes'),
                                ),
                                DropdownMenuItem(
                                  value: 'Wedding Event Themes',
                                  child: Text('Wedding Event Themes'),
                                ),
                                DropdownMenuItem(
                                  value: 'Corporate Event Themes',
                                  child: Text('Corporate Event Themes'),
                                ),
                                DropdownMenuItem(
                                  value: 'Sports Event Themes',
                                  child: Text('Sports Event Themes'),
                                ),
                                DropdownMenuItem(
                                  value: 'Cultural Event Themes',
                                  child: Text('Cultural Event Themes'),
                                ),
                                DropdownMenuItem(
                                  value: 'Religious Event Themes',
                                  child: Text('Religious Event Themes'),
                                )
                              ],
                              value: themes,
                              onChanged: (newvalue) {
                                setState(() {
                                  themes = newvalue;
                                });
                              },
                              validator: (themes) =>
                                  Validations.requireField(themes),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Themes',
                                labelStyle: TTypography.textBlack16,
                              ),
                            ),
                            UIHelpers.verticalSpaceSmall,
                            GradientButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    BlocProvider.of<AddEventBloc>(context)
                                        .add(OnAddEvent(
                                            eventInfo: EventModel(
                                      title:
                                          BlocProvider.of<AddEventBloc>(context)
                                              .eventtitleController
                                              .text,
                                      imageUrl: '$imageUrl',
                                      event_date: '$event_date',
                                      description:
                                          BlocProvider.of<AddEventBloc>(context)
                                              .descriptionController
                                              .text,
                                      service:
                                          BlocProvider.of<AddEventBloc>(context)
                                              .serviceController
                                              .text,
                                      package:
                                          BlocProvider.of<AddEventBloc>(context)
                                              .packageController
                                              .text,
                                      price:
                                          BlocProvider.of<AddEventBloc>(context)
                                              .priceController
                                              .text,
                                      theme: '$themes',
                                      eventtype: '$eventtype',
                                    )));
                                  }
                                },
                                child: const Text(
                                  'Submit',
                                  style: TTypography.textWhite20Bold,
                                ))
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
