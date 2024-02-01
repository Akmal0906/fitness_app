import 'package:json_annotation/json_annotation.dart';



part 'user_model.g.dart';
@JsonSerializable()
class UserModel {
  final String firstname;
  final String lastname;
  final String phone;
  final String password;

  UserModel(
      {required this.firstname,
        required this.lastname,
        required this.phone,
        required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}