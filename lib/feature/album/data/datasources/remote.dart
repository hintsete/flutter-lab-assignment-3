
import '../../../../core/api/api_client.dart';
import '../models/album_model.dart';
import '../models/photo_model.dart';

class AlbumRemoteDataSource {
  final ApiClient apiClient;

  AlbumRemoteDataSource(this.apiClient);

  Future<List<AlbumModel>> fetchAlbums() async => apiClient.getAlbums();
  Future<List<PhotoModel>> fetchPhotos() async => apiClient.getPhotos();
}