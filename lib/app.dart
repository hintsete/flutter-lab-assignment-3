
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'core/api/api_client.dart';
import 'core/router/app_router.dart';
import 'feature/album/data/blocs/album_bloc.dart';
import 'feature/album/data/blocs/album_event.dart';
import 'feature/album/data/datasources/remote.dart';
import 'feature/album/data/repositories/album_repository_impl.dart';
import 'feature/album/domain/usecases/get_albums.dart';
import 'feature/album/domain/usecases/get_photos.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final HttpClient _httpClient;
  late final ApiClient _apiClient;
  late final AlbumRemoteDataSource _remoteDataSource;
  late final AlbumRepositoryImpl _repository;
  late final GetAlbums _getAlbums;
  late final GetPhotos _getPhotos;

  @override
  void initState() {
    super.initState();
    _initializeDependencies();
  }

  void _initializeDependencies() {
    _httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10);

    _apiClient = ApiClient(_httpClient);
    _remoteDataSource = AlbumRemoteDataSource(_apiClient);
    _repository = AlbumRepositoryImpl(_remoteDataSource);
    _getAlbums = GetAlbums(_repository);
    _getPhotos = GetPhotos(_repository);
  }

  @override
  void dispose() {
    _apiClient.close(); // Properly close the HTTP client
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AlbumBloc(
            getAlbums: _getAlbums,
            getPhotos: _getPhotos,
          )..add(FetchAlbums()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Albums App',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        builder: (context, child) {
          ErrorWidget.builder = (errorDetails) =>
          const Center(child: Text('An error occurred'));
          return child!;
        },
      ),
    );
  }
}