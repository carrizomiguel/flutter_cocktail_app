part of 'cocktails_bloc.dart';

enum CocktailsStatus {
  loading,
  success,
  error,
}

class CocktailsState extends Equatable {
  const CocktailsState({
    this.status = CocktailsStatus.loading,
    this.categories = const [],
    this.drinks = const [],
    this.drink,
  });
  
  final CocktailsStatus status;
  final List<String> categories;
  final List<ShortDrinkModel> drinks;
  final DrinkModel? drink;

  CocktailsState copyWith({
    CocktailsStatus? status,
    List<String>? categories,
    List<ShortDrinkModel>? drinks,
    DrinkModel? drink,
  }) {
    return CocktailsState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      drinks: drinks ?? this.drinks,
      drink: drink ?? this.drink,
    );
  }

  @override
  List<Object?> get props => [
    status,
    categories,
    drinks,
    drink,
  ];
}
