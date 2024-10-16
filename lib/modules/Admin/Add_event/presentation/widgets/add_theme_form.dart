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

class AddThemesForm extends StatefulWidget {
  const AddThemesForm({super.key});

  @override
  State<AddThemesForm> createState() => _AddThemesFormState();
}

class _AddThemesFormState extends State<AddThemesForm> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? themes;
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
                'Theme Add Sucessfully!',
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
            BlocProvider.of<AddEventBloc>(context).themetitleController.clear();
            BlocProvider.of<AddEventBloc>(context).themeimageController.clear();
            BlocProvider.of<AddEventBloc>(context)
                .themedescriptionController
                .clear();
            BlocProvider.of<AddEventBloc>(context)
                .themedecorationController
                .clear();
            BlocProvider.of<AddEventBloc>(context)
                .themeactivitiesController
                .clear();
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
                  child: Form(
                    key: formkey,
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            UIHelpers.verticalSpaceSmall,
                            const Text(
                              'THEME INFORMATION',
                              style: TTypography.textBlue22Bold,
                            ),
                            UIHelpers.verticalSpaceLarge,
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
                                labelText: 'Select Theme Type',
                                labelStyle: TTypography.textBlack16,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .themetitleController,
                              validator: (value) =>
                                  Validations.requireField(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: 'Theme Title',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Enter Theme Title',
                                prefixIcon: Icon(TTIcons.event),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .themeimageController,
                              onTap: () async {
                                final image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                setState(() {
                                  if (image != null) {
                                    BlocProvider.of<AddEventBloc>(context)
                                        .themeimageController
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
                                labelText: 'Theme Image',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Add Image',
                                prefixIcon: Icon(TTIcons.imageupload),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .themedescriptionController,
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
                                labelText: 'Theme Description',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Add Description',
                                prefixIcon: Icon(TTIcons.event),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .themedecorationController,
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
                                labelText: 'Theme Decoration',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Add Decoration',
                                prefixIcon: Icon(TTIcons.event),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            TextFormField(
                              controller: BlocProvider.of<AddEventBloc>(context)
                                  .themeactivitiesController,
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
                                labelText: 'Theme Activities',
                                labelStyle: TTypography.textBlack16,
                                hintText: 'Add Activities',
                                prefixIcon: Icon(TTIcons.event),
                                prefixIconColor: TTColors.pink,
                              ),
                            ),
                            UIHelpers.verticalSpaceLarge,
                            GradientButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    BlocProvider.of<AddEventBloc>(context)
                                        .add(OnAddTheme(
                                            themeInfo: ThemeModel(
                                      theme: '$themes',
                                      themetitle:
                                          BlocProvider.of<AddEventBloc>(context)
                                              .themetitleController
                                              .text,
                                      themeimage:
                                          BlocProvider.of<AddEventBloc>(context)
                                              .themeimageController
                                              .text,
                                      themedescription:
                                          BlocProvider.of<AddEventBloc>(context)
                                              .themedescriptionController
                                              .text,
                                      themedecoration:
                                          BlocProvider.of<AddEventBloc>(context)
                                              .themedecorationController
                                              .text,
                                      themeactivities:
                                          BlocProvider.of<AddEventBloc>(context)
                                              .themeactivitiesController
                                              .text,
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
