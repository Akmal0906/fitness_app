import 'package:json_annotation/json_annotation.dart';


part 'local_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LocalModel{
  final String description;
  final String title;
  final num lot;
  final num lat;
  LocalModel({required this.title,required this.description,required this.lat,required this.lot});

  factory LocalModel.fromJson(Map<String, dynamic> json) => _$LocalModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocalModelToJson(this);
}