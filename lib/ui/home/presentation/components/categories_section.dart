import 'package:flutter/material.dart';
import 'package:flutter_cocktail_app/ui/cocktails/cocktails.dart';
import 'package:flutter_cocktail_app/ui/home/presentation/components/custom_sliver_delegate.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSliverDelegate(
      pinned: true,
      height: 70,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        color: Colors.white,
        child: const CategoriesHorizontalList(),
      ),
    );
  }
}
