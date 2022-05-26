import 'package:flutter_cocktail_app/core/error/exceptions.dart';
import 'package:flutter_cocktail_app/core/error/failures.dart';
import 'package:flutter_cocktail_app/core/network/network_info.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/datasources/coktails_remote_data_source.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/short_drink_model.dart';
import 'package:oxidized/oxidized.dart';

abstract class CocktailsRepository {
  Future<Result<List<String>, Failure>> getCategories();
  Future<Result<List<ShortDrinkModel>, Failure>> getDrinksByCategory(
    String category,
  );
  Future<Result<DrinkModel, Failure>> getDrinkById(String id);
}

class CocktailsRepositoryImpl implements CocktailsRepository {
  CocktailsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final CocktailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Result<List<String>, Failure>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getCategories();
        return Result.ok(remote);
      } on BadRequestException {
        return Result.err(BadRequestFailure());
      }
    } else {
      return Result.err(ConnectionFailure());
    }
  }

  @override
  Future<Result<List<ShortDrinkModel>, Failure>> getDrinksByCategory(
    String category,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getDrinksByCategory(
          category,
        );
        return Result.ok(remote);
      } on BadRequestException {
        return Result.err(BadRequestFailure());
      }
    } else {
      return Result.err(ConnectionFailure());
    }
  }

  @override
  Future<Result<DrinkModel, Failure>> getDrinkById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getDrinkById(
          id,
        );
        return Result.ok(remote);
      } on BadRequestException {
        return Result.err(BadRequestFailure());
      }
    } else {
      return Result.err(ConnectionFailure());
    }
  }
}
