import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAlbums extends AlbumEvent {}

class FetchPhotos extends AlbumEvent {
  final int albumId;

  FetchPhotos(this.albumId);

  @override
  List<Object?> get props => [albumId];
}