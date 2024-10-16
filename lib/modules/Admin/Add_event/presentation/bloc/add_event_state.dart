//Pooja Kaloji

abstract class AddEventState {}

final class AddEventInitialState extends AddEventState {}

final class AddEventLoadingState extends AddEventState {}

final class AddEventSucessState extends AddEventState {}

final class AddEventErrorState extends AddEventState {
  String error;
  AddEventErrorState({required this.error});
}

final class AddEventFailureState extends AddEventState {
  String message;
  AddEventFailureState({required this.message});
}