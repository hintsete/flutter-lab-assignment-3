import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/album_bloc.dart';
import '../blocs/album_event.dart';
import '../blocs/album_state.dart';
import '../widgets/album_list_item.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import 'package:collection/collection.dart';

class AlbumListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return LoadingWidget();
          } else if (state is AlbumLoaded) {
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
                final photo = state.photos.firstWhereOrNull((p) => p.albumId == album.id);
                return AlbumListItem(album: album, photo: photo);
              },
            );
          } else if (state is AlbumError) {
            return ErrorDisplayWidget(message: state.message, onRetry: () {
              context.read<AlbumBloc>().add(FetchAlbums());
            });
          }
          return Container();
        },
      ),
    );
  }
}