import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/locals/local_model.dart';
import 'package:fitness_app/domain/signIn_model/sign_model.dart';
import '../../data/network/api.dart';
import '../../domain/models/user_model.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<AddEvent>(_registerFun);
    on<LoginEvent>(_loginFunc);
    on<SaveAdressEvent>(_saveAdress);
  }

  void _registerFun(AddEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(LoadingState());
      final apirequest = ApiClient(Dio());
      final data = await apirequest.createAuth(event.userModel);
      emit(RegisterSuccessState(
          message: data.message, accessToken: data.accessToken));
    } catch (e) {
      emit(const ErrorState(error: 'Something went wrong'));
    }
  }

  void _loginFunc(LoginEvent event, Emitter<RegisterState> emit) async {
    try {
      try {
        emit(LoadingState());
        final apirequest = ApiClient(Dio());
        final data = await apirequest.loginAuth(
            SignModel(firstname: event.firstname, password: event.password));
        emit(RegisterSuccessState(
            message: data.user!.firstname!, accessToken: data.token!));
      } catch (e) {
        emit(const ErrorState(error: 'Something went wrong'));
      }
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  void _saveAdress(SaveAdressEvent event, Emitter<RegisterState> emit) async {
    try {
      try {
        emit(LoadingState());
        final apirequest = ApiClient(Dio());
        final data = await apirequest.addAdress(
          event.localModel);
        emit(SuccessSavedAddressState(
            title: data.title, description: data.description));
      } catch (e) {
        emit(const ErrorState(error: 'Something went wrong'));
      }
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
