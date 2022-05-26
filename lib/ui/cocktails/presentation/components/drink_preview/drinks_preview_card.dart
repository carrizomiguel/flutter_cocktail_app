import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/short_drink_model.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/bloc/cocktails_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DrinksPreviewCard extends StatelessWidget {
  const DrinksPreviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CocktailsBloc, CocktailsState>(
      builder: (context, state) {
        switch (state.drinksStatus) {
          case CocktailsStatus.loading:
            return Container();
          case CocktailsStatus.success:
            List<ShortDrinkModel> drinks = [...state.drinks];
            drinks.removeRange(0, 5);

            return DrinksGridView(
              drinks: drinks,
            );
          case CocktailsStatus.error:
            return Container();
        }
      },
    );
  }
}

class DrinksGridView extends StatelessWidget {
  const DrinksGridView({
    Key? key,
    required this.drinks,
  }) : super(key: key);

  final List<ShortDrinkModel> drinks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 170,
      ),
      shrinkWrap: true,
      itemCount: drinks.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final drink = drinks[index];

        return CachedNetworkImage(
          imageUrl: drink.strDrinkThumb,
          imageBuilder: (context, imageProvider) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                drink.strDrink,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.armata().fontFamily,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: const ColorFilter.mode(
                    Colors.black38,
                    BlendMode.darken,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
