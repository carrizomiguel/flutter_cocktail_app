import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';

class IngredientsLittlePreview extends StatelessWidget {
  const IngredientsLittlePreview({
    Key? key,
    required this.ingredients,
  }) : super(key: key);

  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < ingredients.length; i++) ...[
          if (i < 3) ...[
            Align(
              widthFactor: .8,
              child: CachedNetworkImage(
                imageUrl: getImgUrl(
                  ingredients[i].name,
                ),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 16,
                          offset: Offset(-4, 0),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
        if (ingredients.length > 3) ...[
          const SizedBox(width: 15),
          Text(
            '+${ingredients.length - 3}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ],
    );
  }

  String getImgUrl(String ingredient) {
    final urlify = ingredient.replaceAll(' ', '%20');
    return 'https://www.thecocktaildb.com/images/ingredients/$urlify-Small.png';
  }
}
