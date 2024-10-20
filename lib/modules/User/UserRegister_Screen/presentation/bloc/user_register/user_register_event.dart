import 'package:event_orientation_app/modules/User/UserRegister_Screen/data/models/user_model.dart';

abstract class UserRegisterEvent {}

final class OnSubmitEvent extends UserRegisterEvent {
  final User user;
  OnSubmitEvent({required this.user});
}
