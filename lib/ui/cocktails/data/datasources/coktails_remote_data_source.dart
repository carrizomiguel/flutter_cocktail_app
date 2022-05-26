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
  String authority = Api.authority;
  String list = Api.list;
  String filter = Api.filter;
  String lookup = Api.lookup;
  String search = Api.search;

  @override
  Future<List<String>> getCategories() async {
    final response = await http.get(
      Uri.https(authority, list, {'c': 'list'}),
    );
    // ignore: avoid_print
    print(
        'CATEGORIES RESPONSE ===> status: ${response.statusCode} - body: ${response.body}');
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
    final response = await http.get(
      Uri.https(authority, filter, {'c': category}),
    );
    // ignore: avoid_print
    print(
        'DRINKS RESPONSE ===> status: ${response.statusCode} - body: ${response.body}');
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
    final response = await http.get(
      Uri.https(authority, lookup, {'i': id}),
    );
    // ignore: avoid_print
    print(
        'DRINK BY ID RESPONSE ===> status: ${response.statusCode} - body: ${response.body}');
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
    final response = await http.get(
      Uri.https(authority, search, {'s': key}),
    );
    // ignore: avoid_print
    print(
        'DRINK BY NAME RESPONSE ===> status: ${response.statusCode} - body: ${response.body}');
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
