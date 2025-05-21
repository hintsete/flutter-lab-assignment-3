import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/album_bloc.dart';
import '../blocs/album_state.dart';
import 'package:collection/collection.dart';

class AlbumDetailScreen extends StatelessWidget {
  final int albumId;

  const AlbumDetailScreen({required this.albumId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoaded) {
            final album = state.albums.firstWhere((a) => a.id == albumId);
            final photo = state.photos.firstWhereOrNull((p) => p.albumId == albumId);
            if (photo == null) {
              return const Center(child: Text('No photo found for this album'));
            }

            if (photo == null) {
              return const Center(child: Text('No photo found for this album'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'album-$albumId-image',
                    child: CachedNetworkImage(
                      imageUrl: photo.url,
                      placeholder: (context, url) => Container(
                        height: 300,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 300,
                        child: const Center(child: Icon(Icons.error)),
                      ),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    album.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('Album ID: $albumId'),
                  const SizedBox(height: 16),
                  Text(
                    'Photo Details:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(photo.title),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}