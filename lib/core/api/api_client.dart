import 'dart:convert';
import 'dart:io';
import '../../feature/album/data/models/album_model.dart';
import '../../feature/album/data/models/photo_model.dart';

class ApiClient {
  final HttpClient _httpClient;

  // Updated constructor to accept HttpClient
  ApiClient(this._httpClient);

  Future<List<AlbumModel>> getAlbums() async {
    return _fetchData<AlbumModel>(
      endpoint: 'albums',
      fromJson: AlbumModel.fromJson,
    );
  }

  Future<List<PhotoModel>> getPhotos() async {
    return _fetchData<PhotoModel>(
      endpoint: 'photos',
      fromJson: PhotoModel.fromJson,
    );
  }

  Future<List<T>> _fetchData<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    HttpClientRequest? request;
    try {
      request = await _httpClient.getUrl(
          Uri.parse('https://jsonplaceholder.typicode.com/$endpoint')
      );
      final response = await request.close();

      if (response.statusCode != HttpStatus.ok) {
        throw HttpException('Request failed with status ${response.statusCode}');
      }

      final json = await response.transform(utf8.decoder).join();
      return (jsonDecode(json) as List).map<T>((e) => fromJson(e)).toList();
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (e) {
      throw Exception('Failed to fetch $endpoint: $e');
    } finally {
      request?.abort(); // Clean up if request is still pending
    }
  }

  void close() {
    _httpClient.close(force: true); // Force close all connections
  }
}