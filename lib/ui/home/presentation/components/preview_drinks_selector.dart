import 'package:flutter/material.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/components/drink_preview/drink_preview_column.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/components/drinks_preview_list.dart';

class PreviewDrinksSelector extends StatelessWidget {
  const PreviewDrinksSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 30,
        ),
        child: Row(
          children: const [
            Expanded(
              flex: 1,
              child: DrinksPreviewList(),
            ),
            SizedBox(width: 40),
            Expanded(
              flex: 2,
              child: DrinkPreviewColumn(),
            ),
          ],
        ),
      ),
    );
  }
}
