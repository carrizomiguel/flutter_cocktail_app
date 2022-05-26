import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/bloc/cocktails_bloc.dart';

class CategoriesHorizontalList extends StatelessWidget {
  const CategoriesHorizontalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CocktailsBloc, CocktailsState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: ListView.builder(
            itemCount: state.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final cocktailsBloc = context.read<CocktailsBloc>();
              final selected = cocktailsBloc.categorySelected;

              final category = state.categories[index];

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  left: index == 0 ? 30 : 0,
                  right: index == state.categories.length - 1 ? 30 : 15,
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selected == category ? Colors.white : Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  color: selected == category ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
