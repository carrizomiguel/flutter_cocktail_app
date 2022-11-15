import 'package:equatable/equatable.dart';

class ShortDrinkModel extends Equatable {
  const ShortDrinkModel({
    required this.strDrink,
    required this.strDrinkThumb,
    required this.idDrink,
  });

  final String strDrink;
  final String strDrinkThumb;
  final String idDrink;

  const ShortDrinkModel.empty()
      : this(
          strDrink: '',
          strDrinkThumb: '',
          idDrink: '',
        );

  factory ShortDrinkModel.fromJson(Map<String, dynamic> json) =>
      ShortDrinkModel(
        strDrink: json["strDrink"],
        strDrinkThumb: json["strDrinkThumb"],
        idDrink: json["idDrink"],
      );

  @override
  List<Object?> get props => [
        strDrink,
        strDrinkThumb,
        idDrink,
      ];
}
