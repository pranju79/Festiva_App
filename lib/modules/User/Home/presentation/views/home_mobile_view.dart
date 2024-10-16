import 'package:event_orientation_app/modules/User/Event_Screen/presentation/bloc/event_bloc.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/bloc/event_event.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/bloc/event_state.dart';
import 'package:event_orientation_app/modules/User/Home/presentation/widgets/home_carousel.dart';
import 'package:event_orientation_app/modules/User/Home/presentation/widgets/home_event.dart';
import 'package:event_orientation_app/modules/User/Home/presentation/widgets/home_upcoming_event.dart';
import 'package:event_orientation_app/modules/User/user-drawer/user_drawer.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;

    return BlocProvider(
      create: (context) => EventBloc()..add(FetchEvents()),
      child: Scaffold(
      appBar: AppBar(
        foregroundColor: TTColors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/userprofile',
                arguments: email,
              );
            },
            icon: const Icon(
              TTIcons.profileRounded,
              color: TTColors.white,
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: TTColors.gradientColor,
          ),
        ),
      ),
      drawer: UserDrawer(email: email),
      body: SingleChildScrollView(
          child: BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              if (state is EventLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EventLoaded) {
                final events = state.events;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarouselWidget(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GradientText(
                          '  Events',
                          gradient: TTColors.gradientColor,
                          style: TTypography.textGradient,
                        ),
                      ),
                    ),
                    Container(
                      height: 130,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: EventListWidget(events: events,email: email,),
                    ),
                  
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GradientText(
                          '  Upcoming Events',
                          gradient: TTColors.gradientColor,
                          style: TTypography.textGradient,
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: UpcomingEventsWidget(events: events,email: email,),
                    ),
                  ],
                );
              } else if (state is EventError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('Something went wrong!'));
              }
            },
          ),
        ),
      ),
    );
  }
}
