import '../entities/photo.dart';
import '../repositories/album_repository.dart';

class GetPhotos {
  final AlbumRepository repository;

  GetPhotos(this.repository);

  Future<List<Photo>> call() => repository.getPhotos();
}