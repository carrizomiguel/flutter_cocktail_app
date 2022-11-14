import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/bloc/cocktails_bloc.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/components/drink_preview/drink_preview_loading.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/components/ingredients_little_preview.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/pages/drink_detail_page.dart';
import 'package:google_fonts/google_fonts.dart';

class DrinkPreviewColumn extends StatelessWidget {
  const DrinkPreviewColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CocktailsBloc, CocktailsState>(
      builder: (context, state) {
        switch (state.drinkPreviewStatus) {
          case CocktailsStatus.loading:
            return const DrinkPreviewLoading();
          case CocktailsStatus.success:
            final drink = state.drink!;

            return DrinkPreviewContent(
              drink: drink,
            );
          case CocktailsStatus.error:
            return Container();
        }
      },
    );
  }
}

class DrinkPreviewContent extends StatelessWidget {
  const DrinkPreviewContent({
    Key? key,
    required this.drink,
  }) : super(key: key);

  final DrinkModel drink;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: drink.strDrinkThumb,
          imageBuilder: (context, imageProvider) {
            return Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Text(
          drink.strDrink,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.armata().fontFamily,
          ),
        ),
        const SizedBox(height: 20),
        IngredientsLittlePreview(
          ingredients: drink.ingredients,
        ),
        const SizedBox(height: 20),
        OpenContainer(
          closedElevation: 0,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          transitionType: ContainerTransitionType.fadeThrough,
          openBuilder: (context, action) => const DrinkDetailPage(),
          closedBuilder: (_, action) => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final cocktailsBloc = context.read<CocktailsBloc>();
                cocktailsBloc.add(CocktailsGetDrinkById(
                  id: drink.idDrink,
                ));
                action();
              },
              child: const Text(
                'View Details',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
