// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalModel _$LocalModelFromJson(Map<String, dynamic> json) => LocalModel(
      title: json['title'] as String,
      description: json['description'] as String,
      lat: json['lat'] as num,
      lot: json['lot'] as num,
    );

Map<String, dynamic> _$LocalModelToJson(LocalModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'title': instance.title,
      'lot': instance.lot,
      'lat': instance.lat,
    };
