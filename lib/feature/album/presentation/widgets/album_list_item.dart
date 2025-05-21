import 'package:flutter/material.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/photo.dart';
import 'package:go_router/go_router.dart';

class AlbumListItem extends StatelessWidget {
  final Album album;
  final Photo? photo;

  const AlbumListItem({super.key, required this.album, this.photo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: photo != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            photo!.thumbnailUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 50);
            },
          ),
        )
            : const Icon(Icons.photo_album, size: 50),
        title: Text(
          album.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        onTap: () {
          context.go('/album/${album.id}');
        },
      ),
    );
  }
}
