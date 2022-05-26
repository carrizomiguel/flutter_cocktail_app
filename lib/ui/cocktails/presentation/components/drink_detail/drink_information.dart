import 'package:flutter/material.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';

class DrinkInformation extends StatelessWidget {
  const DrinkInformation({
    Key? key,
    required this.drink,
  }) : super(key: key);

  final DrinkModel drink;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InfoItem(
          infoTitle: 'Glass Type',
          infoValue: drink.strGlass,
        ),
        Container(
          width: 2,
          height: 20,
          color: Colors.grey.shade400,
        ),
        InfoItem(
          infoTitle: 'Category',
          infoValue: drink.strCategory,
        ),
        Container(
          width: 2,
          height: 20,
          color: Colors.grey.shade400,
        ),
        InfoItem(
          infoTitle: 'Strength',
          infoValue: drink.strAlcoholic,
        ),
      ],
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({
    Key? key,
    required this.infoTitle,
    required this.infoValue,
  }) : super(key: key);

  final String infoTitle;
  final String infoValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            infoTitle,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 12,
            ),
          ),
          Text(
            infoValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.orange.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
