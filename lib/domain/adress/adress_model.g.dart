// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdressModel _$AdressModelFromJson(Map<String, dynamic> json) => AdressModel(
      title: json['title'] as String,
      description: json['description'] as String,
      id: json['id'] as int,
      lat: json['lat'] as num,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AdressModelToJson(AdressModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'lat': instance.lat,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'id': instance.id,
    };
