import 'package:json_annotation/json_annotation.dart';


part 'adress_model.g.dart';
@JsonSerializable()
class AdressModel {
  final String title;
  final String description;
  final num lat;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt  ;
  final int id;

  AdressModel(
      {required this.title,
      required this.description,
      required this.id,
      required this.lat,
      required this.createdAt,
      required this.updatedAt});

  factory AdressModel.fromJson(Map<String, dynamic> json) => _$AdressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdressModelToJson(this);
}
