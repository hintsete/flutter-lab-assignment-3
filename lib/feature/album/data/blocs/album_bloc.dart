import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_event.dart';
import 'album_state.dart';
import '../../domain/usecases/get_albums.dart';
import '../../domain/usecases/get_photos.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbums getAlbums;
  final GetPhotos getPhotos;

  AlbumBloc({required this.getAlbums, required this.getPhotos}) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await getAlbums();
        final photos = await getPhotos();
        emit(AlbumLoaded(albums: albums, photos: photos));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });
  }
}