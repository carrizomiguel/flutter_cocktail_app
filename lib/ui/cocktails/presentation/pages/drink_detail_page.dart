import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/bloc/cocktails_bloc.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/components/drink_detail/drink_images_view.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/components/drink_detail/drink_information.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/components/drink_detail/drink_ingredients_table.dart';
import 'package:google_fonts/google_fonts.dart';

class DrinkDetailPage extends StatelessWidget {
  const DrinkDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CocktailsBloc, CocktailsState>(
      builder: (context, state) {
        final drink = state.drink!;
        final ingredientsN = drink.ingredients.take(
          drink.ingredients.length > 4 ? 3 : drink.ingredients.length,
        );

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                drink.strDrink,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              sliver: SliverToBoxAdapter(
                child: DrinkImagesView(
                  drink: drink,
                  ingredientsN: ingredientsN,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 25,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  drink.strInstructions,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade500,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 5,
              ),
              sliver: SliverToBoxAdapter(
                child: DrinkInformation(
                  drink: drink,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 5,
              ),
              sliver: SliverToBoxAdapter(
                child: DrinkIngredientsTable(
                  ingredients: drink.ingredients,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
