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
  const FeedbackPage({super.key,required this.email});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 0; // Variable to hold the rating
  bool _submitted = false; // Track submission state
  String _selectedDate = ""; // Variable to hold selected date

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
              _submitted = true; // Set submitted state
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
            appBar: AppBar(
              foregroundColor: TTColors.white,
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
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
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Please enter your name"
                                        : null,
                              ),
                              UIHelpers.verticalSpaceMedium,
                              TextFormField(
                                readOnly: true,
                                controller: TextEditingController(text: widget.email),
                                decoration: const InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder()),
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
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Please enter the event"
                                        : null,
                              ),
                              UIHelpers.verticalSpaceMedium,
                              TextFormField(
                                readOnly:
                                    true, // Make field read-only to prevent manual input
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
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _rating = index + 1; // Update rating
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
                                      // Pass the text controllers and rating to the SubmitFeedback event
                                      bloc.add(
                                        SubmitFeedback(
                                          name: bloc.nameController.text,
                                          email: widget.email,
                                          event: bloc.eventController.text,
                                          date:
                                              _selectedDate, // Include selected date
                                          feedback:
                                              bloc.feedbackController.text,
                                          rating: _rating, // Include the rating
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text("Submit",
                                      style: TTypography.textWhite26),
                                ),
                              ),
                              UIHelpers.verticalSpaceLarge,
                              // ElevatedButton(
                              //   onPressed: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(builder: (context) => FeedbackListPage()),
                              //     );
                              //   },
                              //   child: const Text("View Feedback List"),
                              // ),
                            ],
                          ),
                        ),
                        // Display rating after submission
                        if (_submitted) ...[
                          UIHelpers.verticalSpaceLarge,
                          Column(
                            children: [
                              const Text("Your Rating:",
                                  style: TTypography.textBlue30Bold),
                              UIHelpers
                                  .verticalSpaceSmall, // Optional space between label and stars
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

  // Method to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate =
            "${picked.toLocal()}".split(' ')[0]; // Format date as needed
      });
    }
  }
}
