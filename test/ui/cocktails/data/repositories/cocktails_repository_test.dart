import 'package:flutter_cocktail_app/core/network/network_info.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/datasources/coktails_remote_data_source.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/short_drink_model.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/repositories/cocktails_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';

class MockCocktailsRemoteDataSource extends Mock
    implements CocktailsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockCocktailsRemoteDataSource mockRemoteDataSource;
  late CocktailsRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockCocktailsRemoteDataSource();
    repository = CocktailsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  test('should check if the device is online', () async {
    when(
      () => mockNetworkInfo.isConnected,
    ).thenAnswer((_) async => true);

    final result = await mockNetworkInfo.isConnected;

    verify(() => mockNetworkInfo.isConnected);
    expect(result, true);
  });

  group('device is online', () {
    setUp(() {
      when(
        () => mockNetworkInfo.isConnected,
      ).thenAnswer((_) async => true);
    });

    test('getCategories', () async {
      final tCategories = ['', ''];
      // Arrange
      when(
        () => mockRemoteDataSource.getCategories(),
      ).thenAnswer((_) async => tCategories);
      // Act
      final result = await repository.getCategories();
      // Assert
      verify(() => mockRemoteDataSource.getCategories());
      expect(result, isA<Ok>());
    });

    test('getDrinksByCategory', () async {
      const tCategory = 'Cocktail';
      final tDrinks = [
        ShortDrinkModel(
          idDrink: '0',
          strDrink: '',
          strDrinkThumb: '',
        ),
      ];
      // Arrange
      when(
        () => mockRemoteDataSource.getDrinksByCategory(
          tCategory,
        ),
      ).thenAnswer((_) async => tDrinks);
      // Act
      final result = await repository.getDrinksByCategory(
        tCategory,
      );
      // Assert
      verify(() => mockRemoteDataSource.getDrinksByCategory(tCategory));
      expect(result, isA<Ok>());
    });

    test('getDrinkById', () async {
      const tIdDrink = '15346';
      final tDrink = DrinkModel(
        idDrink: '',
        strDrink: '',
        strDrinkAlternate: '',
        strCategory: '',
        strAlcoholic: '',
        strGlass: '',
        strInstructions: '',
        strDrinkThumb: '',
        ingredients: [],
        strCreativeCommonsConfirmed: '',
      );
      // Arrange
      when(
        () => mockRemoteDataSource.getDrinkById(
          tIdDrink,
        ),
      ).thenAnswer((_) async => tDrink);
      // Act
      final result = await repository.getDrinkById(
        tIdDrink,
      );
      // Assert
      verify(() => mockRemoteDataSource.getDrinkById(tIdDrink));
      expect(result, isA<Ok>());
    });

    test('getWantedDrinks', () async {
      const tSearchKey = 'Margarita';
      final tDrinks = [
        ShortDrinkModel(
          idDrink: '0',
          strDrink: '',
          strDrinkThumb: '',
        ),
      ];
      // Arrange
      when(
        () => mockRemoteDataSource.getWantedDrinks(
          tSearchKey,
        ),
      ).thenAnswer((_) async => tDrinks);
      // Act
      final result = await repository.getWantedDrinks(
        tSearchKey,
      );
      // Assert
      verify(() => mockRemoteDataSource.getWantedDrinks(tSearchKey));
      expect(result, isA<Ok>());
    });
  });
}
