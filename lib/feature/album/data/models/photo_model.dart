import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/photo.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel extends Photo {
  PhotoModel({
    required int albumId,
    required int id,
    required String title,
    required String url,
    required String thumbnailUrl,
  }) : super(
    albumId: albumId,
    id: id,
    title: title,
    url: url,
    thumbnailUrl: thumbnailUrl,
  );

  factory PhotoModel.fromJson(Map<String, dynamic> json) => _$PhotoModelFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
}