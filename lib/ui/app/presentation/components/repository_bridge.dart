import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cocktail_app/core/network/network_info.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/datasources/coktails_remote_data_source.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/repositories/cocktails_repository.dart';
import 'package:http/http.dart' as http;

class RepositoryBridge extends StatelessWidget {
  RepositoryBridge({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  // Network Info
  final networkInfo = NetworkInfoImpl();

  // Cocktails Repository
  final cocktailsRemoteDataSource = CocktailsRemoteDataSourceImpl(
    client: http.Client(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => CocktailsRepositoryImpl(
            remoteDataSource: cocktailsRemoteDataSource,
            networkInfo: networkInfo,
          ),
        ),
      ],
      child: child,
    );
  }
}
