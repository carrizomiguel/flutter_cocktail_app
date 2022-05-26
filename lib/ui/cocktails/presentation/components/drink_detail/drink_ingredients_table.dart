import 'package:flutter/material.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';
import 'package:google_fonts/google_fonts.dart';

class DrinkIngredientsTable extends StatelessWidget {
  const DrinkIngredientsTable({
    Key? key,
    required this.ingredients,
  }) : super(key: key);

  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredients',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.koulen().fontFamily,
            ),
          ),
          Container(
            width: 50,
            height: 5,
            color: Colors.orange.shade500,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: ingredients.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final ingredient = ingredients[index];

              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        ingredient.measure ?? '',
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        ingredient.name,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: index == 0 ? Colors.white : Colors.grey.shade400,
                      width: index == 0 ? 0 : 1,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 24,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
