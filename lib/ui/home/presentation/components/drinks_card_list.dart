import 'package:flutter/material.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/components/drink_preview/drinks_preview_card.dart';

class DrinksCardList extends StatelessWidget {
  const DrinksCardList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      sliver: SliverToBoxAdapter(
        child: DrinksPreviewCard(),
      ),
    );
  }
}