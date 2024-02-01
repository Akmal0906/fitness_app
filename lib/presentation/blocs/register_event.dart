part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

final class AddEvent extends RegisterEvent {
  final UserModel userModel;

  const AddEvent({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

final class LoginEvent extends RegisterEvent {
  final String firstname;
  final String password;

  const LoginEvent({required this.firstname, required this.password});

  @override
  List<Object?> get props => [firstname, password];
}

final class SaveAdressEvent extends RegisterEvent {
  final LocalModel localModel;

  const SaveAdressEvent({required this.localModel});

  @override
  List<Object?> get props => [localModel];
}
