import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/bloc/cocktails_bloc.dart';
import 'package:flutter_cocktail_app/ui/widgets/shimmer_loading.dart';

class DrinksPreviewList extends StatelessWidget {
  const DrinksPreviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CocktailsBloc, CocktailsState>(
      builder: (context, state) {
        final cocktailsBloc = context.read<CocktailsBloc>();
        final selectedDrink = cocktailsBloc.drinkPreviewSelected.idDrink;

        switch (state.drinksStatus) {
          case CocktailsStatus.loading:
            return ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ShimmerLoading(
                  height: index == 0 ? 85 : 105,
                  borderRadius: 20,
                  margin: EdgeInsets.only(
                    top: index == 0 ? 0 : 20,
                    // bottom: 20,
                  ),
                );
              },
            );
          case CocktailsStatus.success:
            return ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final drink = state.drinks[index];
                return CachedNetworkImage(
                  imageUrl: drink.strDrinkThumb,
                  imageBuilder: (context, imageProvider) {
                    final isSelected = selectedDrink == drink.idDrink;

                    return GestureDetector(
                      onTap: () {
                        cocktailsBloc.add(CocktailsGetDrinkById(
                          id: drink.idDrink,
                        ));
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 85,
                        margin: EdgeInsets.only(
                          top: index == 0 ? 0 : 20,
                        ),
                        padding: EdgeInsets.all(
                          isSelected ? 5 : 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.white,
                            width: isSelected ? 1 : 0,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return ShimmerLoading(
                      height: index == 0 ? 85 : 105,
                      borderRadius: 20,
                      margin: EdgeInsets.only(
                        top: index == 0 ? 0 : 20,
                        // bottom: 20,
                      ),
                    );
                  },
                );
              },
            );
          case CocktailsStatus.error:
            return Container();
        }
      },
    );
  }
}
