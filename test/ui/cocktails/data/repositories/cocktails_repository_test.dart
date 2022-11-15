import 'package:flutter_cocktail_app/core/error/exceptions.dart';
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

  test('should return true when is online', () async {
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

    group('success responses', () {
      test('should return categories when getCategories called', () async {
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

      test('should return drinks when getDrinksByCategory called', () async {
        const tCategory = 'Cocktail';
        final tDrinks = [
          const ShortDrinkModel(
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

      test('should return drink when getDrinkById called', () async {
        const tIdDrink = '15346';
        const tDrink = DrinkModel(
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

      test('should return drink when getWantedDrinks called', () async {
        const tSearchKey = 'Margarita';
        final tDrinks = [
          const ShortDrinkModel(
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

    group('error responses', () {
      test('should fail in getCategories for BadRequest', () async {
        // Arrange
        when(
          () => mockRemoteDataSource.getCategories(),
        ).thenThrow(BadRequestException());
        // Act
        final result = await repository.getCategories();
        // Assert
        verify(() => mockRemoteDataSource.getCategories());
        expect(result, isA<Err>());
      });

      test('should fail in getDrinksByCategory for BadRequest', () async {
        const tCategory = 'Cocktail';
        // Arrange
        when(
          () => mockRemoteDataSource.getDrinksByCategory(
            tCategory,
          ),
        ).thenThrow(BadRequestException());
        // Act
        final result = await repository.getDrinksByCategory(
          tCategory,
        );
        // Assert
        verify(() => mockRemoteDataSource.getDrinksByCategory(tCategory));
        expect(result, isA<Err>());
      });

      test('should return drink when getDrinkById called', () async {
        const tIdDrink = '15346';
        // Arrange
        when(
          () => mockRemoteDataSource.getDrinkById(
            tIdDrink,
          ),
        ).thenThrow(BadRequestException());
        // Act
        final result = await repository.getDrinkById(
          tIdDrink,
        );
        // Assert
        verify(() => mockRemoteDataSource.getDrinkById(tIdDrink));
        expect(result, isA<Err>());
      });

      test('should return drink when getWantedDrinks called', () async {
        const tSearchKey = 'Margarita';
        // Arrange
        when(
          () => mockRemoteDataSource.getWantedDrinks(
            tSearchKey,
          ),
        ).thenThrow(BadRequestException());
        // Act
        final result = await repository.getWantedDrinks(
          tSearchKey,
        );
        // Assert
        verify(() => mockRemoteDataSource.getWantedDrinks(tSearchKey));
        expect(result, isA<Err>());
      });
    });
  });

  test('should return false when is not online', () async {
    when(
      () => mockNetworkInfo.isConnected,
    ).thenAnswer((_) async => false);

    final result = await mockNetworkInfo.isConnected;

    verify(() => mockNetworkInfo.isConnected);
    expect(result, false);
  });

  group('device is not online', () {
    test('should fail in getCategories for ConnectionFailure', () async {
      // Arrange
      when(
        () => mockNetworkInfo.isConnected,
      ).thenAnswer((_) async => false);
      // Act
      final result = await repository.getCategories();
      // Assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(() => mockNetworkInfo.isConnected);
      expect(result, isA<Err>());
    });

    test('should fail in getDrinksByCategory for ConnectionFailure', () async {
      const tCategory = 'Cocktail';
      // Arrange
      when(
        () => mockNetworkInfo.isConnected,
      ).thenAnswer((_) async => false);
      // Act
      final result = await repository.getDrinksByCategory(
        tCategory,
      );
      // Assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(() => mockNetworkInfo.isConnected);
      expect(result, isA<Err>());
    });

    test('should fail in getDrinkById for ConnectionFailure', () async {
      const tIdDrink = '15346';
      // Arrange
      when(
        () => mockNetworkInfo.isConnected,
      ).thenAnswer((_) async => false);
      // Act
      final result = await repository.getDrinkById(
        tIdDrink,
      );
      // Assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(() => mockNetworkInfo.isConnected);
      expect(result, isA<Err>());
    });

    test('should fail in getWantedDrinks for ConnectionFailure', () async {
      const tSearchKey = 'Margarita';
      // Arrange
      when(
        () => mockNetworkInfo.isConnected,
      ).thenAnswer((_) async => false);
      // Act
      final result = await repository.getWantedDrinks(
        tSearchKey,
      );
      // Assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(() => mockNetworkInfo.isConnected);
      expect(result, isA<Err>());
    });
  });
}
