import 'dart:convert';

import 'package:flutter_cocktail_app/ui/cocktails/data/models/short_drink_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tShortDrinkModel = ShortDrinkModel(
    strDrink: 'drink',
    strDrinkThumb: 'thumb',
    idDrink: '1',
  );

  test('should return a valid model from json', () async {
    // arrange
    final jsonMap = json.decode(fixture('drink.json'));
    // act
    final result = ShortDrinkModel.fromJson(jsonMap);
    // assert
    expect(result, tShortDrinkModel);
  });

  test('should return a empty model when using empty method', () async {
    // arrange
    const expectedModel = ShortDrinkModel(
      strDrink: '',
      strDrinkThumb: '',
      idDrink: '',
    );
    // act
    const result = ShortDrinkModel.empty();
    // assert
    expect(result, expectedModel);
  });
}
