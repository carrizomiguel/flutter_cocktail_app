import 'dart:convert';

List<ShortDrinkModel> shortDrinkModelFromJson(String str) =>
    List<ShortDrinkModel>.from(
        json.decode(str).map((x) => ShortDrinkModel.fromJson(x)));

String shortDrinkModelToJson(List<ShortDrinkModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShortDrinkModel {
  ShortDrinkModel({
    required this.strDrink,
    required this.strDrinkThumb,
    required this.idDrink,
  });

  String strDrink;
  String strDrinkThumb;
  String idDrink;

  static ShortDrinkModel empty() {
    return ShortDrinkModel(
      strDrink: '',
      strDrinkThumb: '',
      idDrink: '',
    );
  }

  factory ShortDrinkModel.fromJson(Map<String, dynamic> json) =>
      ShortDrinkModel(
        strDrink: json["strDrink"],
        strDrinkThumb: json["strDrinkThumb"],
        idDrink: json["idDrink"],
      );

  Map<String, dynamic> toJson() => {
        "strDrink": strDrink,
        "strDrinkThumb": strDrinkThumb,
        "idDrink": idDrink,
      };
}
