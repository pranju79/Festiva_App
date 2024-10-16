import 'package:event_orientation_app/modules/User/UserRegister_Screen/data/models/user_model.dart';

abstract class LoginEvent  {
  
} 
class LoginButtonPressed extends LoginEvent {
  final User users;

  LoginButtonPressed({required this.users, required String email});
}

