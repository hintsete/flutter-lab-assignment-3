import '../../domain/entities/album.dart';
import '../../domain/entities/photo.dart';
import '../../domain/repositories/album_repository.dart';
import '../datasources/remote.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource remoteDataSource;

  AlbumRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Album>> getAlbums() => remoteDataSource.fetchAlbums();

  @override
  Future<List<Photo>> getPhotos() => remoteDataSource.fetchPhotos();
}