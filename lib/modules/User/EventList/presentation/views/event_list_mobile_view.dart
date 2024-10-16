import 'package:event_orientation_app/modules/User/EventList/presentation/widgets/event_list.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/bloc/event_bloc.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/bloc/event_event.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/bloc/event_state.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventListMobileView extends StatelessWidget {
  String email;
  EventListMobileView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventBloc()..add(FetchEvents()),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: TTColors.white,
          elevation: 0,
          title: const Text('Events'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: TTColors.gradientColor,
            ),
          ),
        ),
        body: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventLoaded) {
              return EventListWidget(
                events: state.events,
                email: email,
              );
            } else if (state is EventError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(
                  child: Text('Press the button to load events'));
            }
          },
        ),
      ),
    );
  }
}
