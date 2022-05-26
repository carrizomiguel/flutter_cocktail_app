part of 'cocktails_bloc.dart';

abstract class CocktailsEvent extends Equatable {
  const CocktailsEvent();

  @override
  List<Object> get props => [];
}

class CocktailsGetCategories extends CocktailsEvent {}

class CocktailsGetDrinksByCategory extends CocktailsEvent {
  const CocktailsGetDrinksByCategory({
    required this.category,
  });

  final String category;
}

class CocktailsGetDrinkById extends CocktailsEvent {
  const CocktailsGetDrinkById({
    required this.id,
  });

  final String id;
}

class CocktailsGetWantedDrinks extends CocktailsEvent {
  const CocktailsGetWantedDrinks({
    required this.key,
  });

  final String key;
}
