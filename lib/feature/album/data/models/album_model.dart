import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/album.dart';

part 'album_model.g.dart';

@JsonSerializable()
class AlbumModel extends Album {
  AlbumModel({
    required int userId,
    required int id,
    required String title,
  }) : super(userId: userId, id: id, title: title);

  factory AlbumModel.fromJson(Map<String, dynamic> json) => _$AlbumModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}