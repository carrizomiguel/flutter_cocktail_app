import 'dart:convert';

import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tDrinkModel = DrinkModel(
    idDrink: '1',
    strDrink: 'drink',
    strDrinkAlternate: null,
    strTags: 'tag',
    strVideo: null,
    strCategory: 'category',
    strIba: 'iba',
    strAlcoholic: 'alcoholic',
    strGlass: 'glass',
    strInstructions: 'instructions',
    strDrinkThumb: 'thumb',
    ingredients: [
      Ingredient(
        name: 'ingredient',
        measure: 'measure',
      ),
    ],
    strImageSource: 'image',
    strImageAttribution: 'image',
    strCreativeCommonsConfirmed: 'confirmed',
  );

  test('should return a valid model from json', () async {
    // arrange
    final jsonMap = json.decode(fixture('drink.json'));
    // act
    final result = DrinkModel.fromJson(jsonMap);
    // assert
    expect(result, tDrinkModel);
  });
}
