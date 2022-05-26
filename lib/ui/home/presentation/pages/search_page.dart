import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/bloc/cocktails_bloc.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/components/drink_preview/drinks_preview_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SearchBody();
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Search Drink',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            sliver: SliverToBoxAdapter(
              child: TextField(
                onChanged: (key) {
                  final cocktailsBloc = context.read<CocktailsBloc>();
                  cocktailsBloc.add(CocktailsGetWantedDrinks(
                    key: key,
                  ));
                },
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade500,
                  ),
                  fillColor: const Color(0xFFF1F1F3),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<CocktailsBloc, CocktailsState>(
                builder: (context, state) {
                  final cocktailsBloc = context.read<CocktailsBloc>();

                  switch (state.drinksStatus) {
                    case CocktailsStatus.loading:
                      return const DrinksGridLoading();
                    case CocktailsStatus.success:
                      if (cocktailsBloc.wantedDrinks.isEmpty) {
                        return Container();
                      }
                      return DrinksGridView(
                        drinks: cocktailsBloc.wantedDrinks,
                      );
                    case CocktailsStatus.error:
                      return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
