import 'package:flutter/material.dart';
import 'package:flutter_cocktail_app/ui/home/presentation/components/categories_section.dart';
import 'package:flutter_cocktail_app/ui/home/presentation/components/custom_search_section.dart';
import 'package:flutter_cocktail_app/ui/home/presentation/components/drinks_card_list.dart';
import 'package:flutter_cocktail_app/ui/home/presentation/components/preview_drinks_selector.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeBody();
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COCKTAILS'),
        titleTextStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const CustomScrollView(
        slivers: [
          CustomSearchSection(),
          CategoriesSection(),
          PreviewDrinksSelector(),
          DrinksCardList(),
        ],
      ),
    );
  }
}
