import 'package:json_annotation/json_annotation.dart';
part 'success_model.g.dart';
@JsonSerializable()
class SuccessModel{
  final String message;
  final String accessToken;
  SuccessModel({required this.message,required this.accessToken});

  factory SuccessModel.fromJson(Map<String, dynamic> json) => _$SuccessModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuccessModelToJson(this);
}