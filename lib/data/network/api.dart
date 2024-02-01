import 'package:fitness_app/domain/adress/adress_model.dart';
import 'package:fitness_app/domain/locals/local_model.dart';
import 'package:fitness_app/domain/login_model/loginModel.dart';
import 'package:fitness_app/domain/signIn_model/sign_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../domain/models/user_model.dart';
import '../../domain/success/success_model.dart';
part 'api.g.dart';

@RestApi(baseUrl:'https://qutb.uz')
abstract class ApiClient{
  factory ApiClient(Dio dio,{String baseUrl}) =_ApiClient;


  @POST('/api/auth/register')
  Future<SuccessModel> createAuth(@Body() UserModel userModel);

  @POST('/api/auth/login')
  Future<LoginModel> loginAuth(@Body() SignModel signModel);

  @POST('/api/ads')
  Future<AdressModel> addAdress(@Body() LocalModel localModel);
}






