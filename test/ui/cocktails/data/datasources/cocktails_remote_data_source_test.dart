import 'package:flutter_cocktail_app/core/error/exceptions.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/datasources/coktails_remote_data_source.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/short_drink_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CocktailsRemoteDataSourceImpl remoteDataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = CocktailsRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });

  group('getCategories', () {
    test('should return Categories List successfully', () async {
      // Arrange
      when(
        () => mockHttpClient.get(Uri.https(
          'www.thecocktaildb.com',
          '/api/json/v1/1/list.php',
          {'c': 'list'},
        )),
      ).thenAnswer(
        (_) async => http.Response(fixture('categories.json'), 200),
      );
      // Act
      final response = await remoteDataSource.getCategories();
      // Assert
      expect(response, isA<List<String>>());
    });

    test('should throw Exception when returns error', () async {
      // Arrange
      when(
        () => mockHttpClient.get(Uri.https(
          'www.thecocktaildb.com',
          '/api/json/v1/1/list.php',
          {'c': 'list'},
        )),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      // Act
      final call = remoteDataSource.getCategories;
      // Assert
      expect(
        () => call(),
        throwsA(const TypeMatcher<BadRequestException>()),
      );
    });
  });

  group('getDrinksByCategory', () {
    const tCategory = 'Cocktail';

    test('should return Drinks List by Category successfully', () async {
      // Arrange
      when(
        () => mockHttpClient.get(Uri.https(
          'www.thecocktaildb.com',
          '/api/json/v1/1/filter.php',
          {'c': tCategory},
        )),
      ).thenAnswer(
        (_) async => http.Response(fixture('drinks_by_category.json'), 200),
      );
      // Act
      final response = await remoteDataSource.getDrinksByCategory(
        tCategory,
      );
      // Assert
      expect(response, isA<List<ShortDrinkModel>>());
    });

    test('should throw Exception when returns error', () async {
      // Arrange
      when(
        () => mockHttpClient.get(Uri.https(
          'www.thecocktaildb.com',
          '/api/json/v1/1/filter.php',
          {'c': tCategory},
        )),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      // Act
      final call = remoteDataSource.getDrinksByCategory;
      // Assert
      expect(
        () => call(tCategory),
        throwsA(const TypeMatcher<BadRequestException>()),
      );
    });
  });

  group('getDrinkById', () {
    const tIdDrink = '15346';

    test('should return Drinks List by Category successfully', () async {
      // Arrange
      when(
        () => mockHttpClient.get(Uri.https(
          'www.thecocktaildb.com',
          '/api/json/v1/1/lookup.php',
          {'i': tIdDrink},
        )),
      ).thenAnswer(
        (_) async => http.Response(fixture('drink_by_id.json'), 200),
      );
      // Act
      final response = await remoteDataSource.getDrinkById(
        tIdDrink,
      );
      // Assert
      expect(response, isA<DrinkModel>());
    });

    test('should throw Exception when returns error', () async {
      // Arrange
      when(
        () => mockHttpClient.get(Uri.https(
          'www.thecocktaildb.com',
          '/api/json/v1/1/lookup.php',
          {'i': tIdDrink},
        )),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      // Act
      final call = remoteDataSource.getDrinkById;
      // Assert
      expect(
        () => call(tIdDrink),
        throwsA(const TypeMatcher<BadRequestException>()),
      );
    });
  });

  group('getWantedDrinks', () {
    const tSearchKey = 'Margarita';

    test('should return Drinks List by Category successfully', () async {
      // Arrange
      when(
        () => mockHttpClient.get(Uri.https(
          'www.thecocktaildb.com',
          '/api/json/v1/1/search.php',
          {'s': tSearchKey},
        )),
      ).thenAnswer(
        (_) async => http.Response(fixture('wanted_drinks.json'), 200),
      );
      // Act
      final response = await remoteDataSource.getWantedDrinks(
        tSearchKey,
      );
      // Assert
      expect(response, isA<List<ShortDrinkModel>>());
    });

    test('should throw Exception when returns error', () async {
      // Arrange
      when(
        () => mockHttpClient.get(Uri.https(
          'www.thecocktaildb.com',
          '/api/json/v1/1/search.php',
          {'s': tSearchKey},
        )),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      // Act
      final call = remoteDataSource.getWantedDrinks;
      // Assert
      expect(
        () => call(tSearchKey),
        throwsA(const TypeMatcher<BadRequestException>()),
      );
    });
  });
}
