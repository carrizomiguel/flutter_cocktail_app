import 'package:equatable/equatable.dart';

class DrinkModel extends Equatable {
  const DrinkModel({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkAlternate,
    this.strTags,
    this.strVideo,
    required this.strCategory,
    this.strIba,
    required this.strAlcoholic,
    required this.strGlass,
    required this.strInstructions,
    required this.strDrinkThumb,
    required this.ingredients,
    this.strImageSource,
    this.strImageAttribution,
    required this.strCreativeCommonsConfirmed,
  });

  final String idDrink;
  final String strDrink;
  final dynamic strDrinkAlternate;
  final String? strTags;
  final String? strVideo;
  final String strCategory;
  final String? strIba;
  final String strAlcoholic;
  final String strGlass;
  final String strInstructions;
  final String strDrinkThumb;
  final List<Ingredient> ingredients;
  final String? strImageSource;
  final String? strImageAttribution;
  final String strCreativeCommonsConfirmed;

  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredients = [];
    for (var i = 1; i <= 15; i++) {
      if (json["strIngredient$i"] != null) {
        ingredients.add(Ingredient(
          name: json["strIngredient$i"],
          measure: json["strMeasure$i"],
        ));
      }
    }

    return DrinkModel(
      idDrink: json["idDrink"],
      strDrink: json["strDrink"],
      strDrinkAlternate: json["strDrinkAlternate"],
      strTags: json["strTags"],
      strVideo: json["strVideo"],
      strCategory: json["strCategory"],
      strIba: json["strIBA"],
      strAlcoholic: json["strAlcoholic"],
      strGlass: json["strGlass"],
      strInstructions: json["strInstructions"],
      strDrinkThumb: json["strDrinkThumb"],
      ingredients: ingredients,
      strImageSource: json["strImageSource"],
      strImageAttribution: json["strImageAttribution"],
      strCreativeCommonsConfirmed: json["strCreativeCommonsConfirmed"],
    );
  }

  @override
  List<Object?> get props => [
        idDrink,
        strDrink,
        strDrinkAlternate,
        strTags,
        strVideo,
        strCategory,
        strIba,
        strAlcoholic,
        strGlass,
        strInstructions,
        strDrinkThumb,
        ingredients,
        strImageSource,
        strImageAttribution,
        strCreativeCommonsConfirmed,
      ];
}

class Ingredient extends Equatable {
  const Ingredient({
    required this.name,
    this.measure,
  });

  final String name;
  final String? measure;

  @override
  List<Object?> get props => [
        name,
        measure,
      ];
}
