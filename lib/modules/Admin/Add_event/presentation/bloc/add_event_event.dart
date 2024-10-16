//Pooja Kaloji

import 'package:event_orientation_app/modules/Admin/Add_event/data/models/event_model.dart';

abstract class AddEventEvent {}

final class OnAddEvent extends AddEventEvent{
  EventModel eventInfo;
  OnAddEvent({required this.eventInfo});
}

final class OnAddTheme extends AddEventEvent{
  ThemeModel themeInfo;
  OnAddTheme({required this.themeInfo});
}