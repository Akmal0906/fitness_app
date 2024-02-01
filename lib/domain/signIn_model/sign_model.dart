import 'package:json_annotation/json_annotation.dart';


part 'sign_model.g.dart';
@JsonSerializable(explicitToJson: true)

class SignModel{
  final String firstname;
  final String password;
  SignModel({required this.firstname,required this.password});
  factory SignModel.fromJson(Map<String, dynamic> json) => _$SignModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignModelToJson(this);
}