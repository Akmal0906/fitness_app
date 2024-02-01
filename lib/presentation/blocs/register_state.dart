part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterSuccessState extends RegisterState {
  final String message;
  final String accessToken;

  const RegisterSuccessState(
      {required this.message, required this.accessToken});

  @override
  List<Object?> get props => [message, accessToken];
}

final class ErrorState extends RegisterState {
  final String error;

  const ErrorState({required this.error});

  @override
  List<Object?> get props => [];
}

final class SuccessSavedAddressState extends RegisterState {
  final String title;
  final String description;

  const SuccessSavedAddressState(
      {required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}
