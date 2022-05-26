import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cocktail_app/core/network/api.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';
import 'package:flutter_cocktail_app/ui/widgets/shimmer_loading.dart';

class DrinkImagesView extends StatelessWidget {
  const DrinkImagesView({
    Key? key,
    required this.drink,
    required this.ingredientsN,
  }) : super(key: key);

  final DrinkModel drink;
  final Iterable<Ingredient> ingredientsN;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CachedNetworkImage(
            imageUrl: drink.strDrinkThumb,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: 210,
                height: 310,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return const ShimmerLoading(
                height: 310,
                width: 210,
                borderRadius: 20,
              );
            },
          ),
        ),
        if (drink.ingredients.length > 3) ...[
          Expanded(
            flex: 1,
            child: Column(
              children: [
                for (var ingredient in ingredientsN) ...[
                  CachedNetworkImage(
                    imageUrl: Api.getImgUrl(ingredient.name),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  )
                ],
                if (drink.ingredients.length > 4) ...[
                  Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      '+${drink.ingredients.length - 3}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ],
            ),
          )
        ],
      ],
    );
  }
}