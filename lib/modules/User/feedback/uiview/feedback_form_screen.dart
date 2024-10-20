import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_orientation_app/modules/User/feedback/feedback_bloc.dart';
import 'package:event_orientation_app/modules/User/feedback/feedback_event.dart';
import 'package:event_orientation_app/modules/User/feedback/feedback_state.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  final String email;
  const FeedbackPage({super.key, required this.email});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 0;
  bool _submitted = false;
  String _selectedDate = "";

  final List<Color> gradientColors = [
    TTColors.blue,
    TTColors.purple,
    TTColors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackBloc(),
      child: BlocConsumer<FeedbackBloc, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackSubmitted) {
            setState(() {
              _submitted = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Feedback submitted successfully!')),
            );
          } else if (state is FeedbackError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<FeedbackBloc>(context);

          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: TTColors.gradientColor,
              ),
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: TTColors.white,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/1484/1484826.png',
                          ),
                        ),
                        UIHelpers.verticalSpaceMedium,
                        const Text("Submit Your Feedback",
                            style: TTypography.textBlue30Bold),
                        UIHelpers.verticalSpaceLargePlus,
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: bloc.nameController,
                                decoration: const InputDecoration(
                                    labelText: "Name",
                                    border: OutlineInputBorder()),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Please enter your name"
                                        : null,
                              ),
                              UIHelpers.verticalSpaceMedium,
                              TextFormField(
                                readOnly: true,
                                controller:
                                    TextEditingController(text: widget.email),
                                decoration: const InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder()),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Please enter your email"
                                        : null,
                              ),
                              UIHelpers.verticalSpaceMedium,
                              TextFormField(
                                controller: bloc.eventController,
                                decoration: const InputDecoration(
                                    labelText: "Event",
                                    border: OutlineInputBorder()),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Please enter the event"
                                        : null,
                              ),
                              UIHelpers.verticalSpaceMedium,
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: "Date",
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_today),
                                    onPressed: () => _selectDate(context),
                                  ),
                                ),
                                controller:
                                    TextEditingController(text: _selectedDate),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Please select a date"
                                        : null,
                              ),
                              UIHelpers.verticalSpaceMedium,
                              TextFormField(
                                controller: bloc.feedbackController,
                                decoration: const InputDecoration(
                                    labelText: "Feedback",
                                    border: OutlineInputBorder()),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Please enter your feedback"
                                        : null,
                              ),
                              UIHelpers.verticalSpaceMedium,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return IconButton(
                                    icon: Icon(
                                      index < _rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: TTColors.purple,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _rating = index + 1;
                                      });
                                    },
                                  );
                                }),
                              ),
                              UIHelpers.verticalSpaceLarge,
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              TTColors.purple)),
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      bloc.add(
                                        SubmitFeedback(
                                          name: bloc.nameController.text,
                                          email: widget.email,
                                          event: bloc.eventController.text,
                                          date: _selectedDate,
                                          feedback:
                                              bloc.feedbackController.text,
                                          rating: _rating,
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text("Submit",
                                      style: TTypography.textWhite26),
                                ),
                              ),
                              UIHelpers.verticalSpaceLarge,
                            ],
                          ),
                        ),
                        if (_submitted) ...[
                          UIHelpers.verticalSpaceLarge,
                          Column(
                            children: [
                              const Text("Your Rating:",
                                  style: TTypography.textBlue30Bold),
                              UIHelpers.verticalSpaceSmall,
                              RatingBarIndicator(
                                rating: _rating.toDouble(),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 25.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        ],
                      ],
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
}
