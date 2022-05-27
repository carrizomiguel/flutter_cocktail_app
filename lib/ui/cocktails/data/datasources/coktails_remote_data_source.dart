import 'dart:convert';

import 'package:flutter_cocktail_app/core/error/exceptions.dart';
import 'package:flutter_cocktail_app/core/network/api.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/short_drink_model.dart';
import 'package:http/http.dart' as http;

abstract class CocktailsRemoteDataSource {
  Future<List<String>> getCategories();
  Future<List<ShortDrinkModel>> getDrinksByCategory(
    String category,
  );
  Future<DrinkModel> getDrinkById(String id);
  Future<List<ShortDrinkModel>> getWantedDrinks(
    String key,
  );
}

class CocktailsRemoteDataSourceImpl implements CocktailsRemoteDataSource {
  CocktailsRemoteDataSourceImpl({required this.client});

  final http.Client client;

  String authority = Api.authority;
  String list = Api.list;
  String filter = Api.filter;
  String lookup = Api.lookup;
  String search = Api.search;

  @override
  Future<List<String>> getCategories() async {
    final response = await client.get(
      Uri.https(authority, list, {'c': 'list'}),
    );
    switch (response.statusCode) {
      case 200:
        final decoded = json.decode(response.body);
        List<String> list = List<String>.from(
          decoded['drinks'].map((e) => e['strCategory']),
        );
        return list;
      default:
        throw BadRequestException();
    }
  }

  @override
  Future<List<ShortDrinkModel>> getDrinksByCategory(
    String category,
  ) async {
    final response = await client.get(
      Uri.https(authority, filter, {'c': category}),
    );
    switch (response.statusCode) {
      case 200:
        final decoded = json.decode(response.body);
        List<ShortDrinkModel> drinks = List<ShortDrinkModel>.from(
          decoded['drinks'].map((e) => ShortDrinkModel.fromJson(e)),
        );
        return drinks;
      default:
        throw BadRequestException();
    }
  }

  @override
  Future<DrinkModel> getDrinkById(String id) async {
    final response = await client.get(
      Uri.https(authority, lookup, {'i': id}),
    );
    switch (response.statusCode) {
      case 200:
        final decoded = json.decode(response.body);
        DrinkModel drink = List<DrinkModel>.from(
          decoded['drinks'].map((e) => DrinkModel.fromJson(e)),
        ).first;
        return drink;
      default:
        throw BadRequestException();
    }
  }

  @override
  Future<List<ShortDrinkModel>> getWantedDrinks(String key) async {
    final response = await client.get(
      Uri.https(authority, search, {'s': key}),
    );
    switch (response.statusCode) {
      case 200:
        final decoded = json.decode(response.body);
        List<ShortDrinkModel> drinks = List<ShortDrinkModel>.from(
          decoded['drinks'].map((e) => ShortDrinkModel.fromJson(e)),
        );
        return drinks;
      default:
        throw BadRequestException();
    }
  }
}
