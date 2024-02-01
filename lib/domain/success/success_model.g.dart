// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessModel _$SuccessModelFromJson(Map<String, dynamic> json) => SuccessModel(
      message: json['message'] as String,
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$SuccessModelToJson(SuccessModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'accessToken': instance.accessToken,
    };
