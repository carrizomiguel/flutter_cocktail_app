import 'dart:convert';

DrinkModel drinkFromJson(String str) => DrinkModel.fromJson(json.decode(str));

String drinkToJson(DrinkModel data) => json.encode(data.toJson());

class DrinkModel {
  DrinkModel({
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

  String idDrink;
  String strDrink;
  dynamic strDrinkAlternate;
  String? strTags;
  String? strVideo;
  String strCategory;
  String? strIba;
  String strAlcoholic;
  String strGlass;
  String strInstructions;
  String strDrinkThumb;
  List<Ingredient> ingredients;
  String? strImageSource;
  String? strImageAttribution;
  String strCreativeCommonsConfirmed;

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

  Map<String, dynamic> toJson() => {
        "idDrink": idDrink,
        "strDrink": strDrink,
        "strDrinkAlternate": strDrinkAlternate,
        "strTags": strTags,
        "strVideo": strVideo,
        "strCategory": strCategory,
        "strIBA": strIba,
        "strAlcoholic": strAlcoholic,
        "strGlass": strGlass,
        "strInstructions": strInstructions,
        "strDrinkThumb": strDrinkThumb,
        "ingredients": ingredients,
        "strImageSource": strImageSource,
        "strImageAttribution": strImageAttribution,
        "strCreativeCommonsConfirmed": strCreativeCommonsConfirmed,
      };
}

class Ingredient {
  Ingredient({
    required this.name,
    required this.measure,
  });

  final String name;
  final String measure;
}
