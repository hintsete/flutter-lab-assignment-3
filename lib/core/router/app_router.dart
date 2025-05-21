
import 'package:go_router/go_router.dart';
import '../../feature/album/presentation/screens/album_detail_screen.dart';
import '../../feature/album/presentation/screens/album_list_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AlbumListScreen(),
      routes: [
        GoRoute(
          path: 'album/:id',
          builder: (context, state) {
            final albumId = int.parse(state.pathParameters['id']!);
            return AlbumDetailScreen(albumId: albumId);
          },
        ),
      ],
    ),
  ],
);