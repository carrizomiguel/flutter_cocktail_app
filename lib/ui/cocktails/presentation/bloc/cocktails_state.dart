part of 'cocktails_bloc.dart';

enum CocktailsStatus {
  loading,
  success,
  error,
}

class CocktailsState extends Equatable {
  const CocktailsState({
    this.categoryStatus = CocktailsStatus.loading,
    this.drinksStatus = CocktailsStatus.loading,
    this.drinkPreviewStatus = CocktailsStatus.loading,
    this.categories = const [],
    this.drinks = const [],
    this.drink,
  });
  
  final CocktailsStatus categoryStatus;
  final CocktailsStatus drinksStatus;
  final CocktailsStatus drinkPreviewStatus;
  final List<String> categories;
  final List<ShortDrinkModel> drinks;
  final DrinkModel? drink;

  CocktailsState copyWith({
    CocktailsStatus? categoryStatus,
    CocktailsStatus? drinksStatus,
    CocktailsStatus? drinkPreviewStatus,
    List<String>? categories,
    List<ShortDrinkModel>? drinks,
    DrinkModel? drink,
  }) {
    return CocktailsState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      drinksStatus: drinksStatus ?? this.drinksStatus,
      drinkPreviewStatus: drinkPreviewStatus ?? this.drinkPreviewStatus,
      categories: categories ?? this.categories,
      drinks: drinks ?? this.drinks,
      drink: drink ?? this.drink,
    );
  }

  @override
  List<Object?> get props => [
    categoryStatus,
    drinksStatus,
    drinkPreviewStatus,
    categories,
    drinks,
    drink,
  ];
}
