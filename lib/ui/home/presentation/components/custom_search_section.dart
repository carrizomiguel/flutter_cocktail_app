import 'package:flutter/material.dart';
import 'package:flutter_cocktail_app/ui/home/presentation/components/custom_sliver_delegate.dart';

class CustomSearchSection extends StatelessWidget {
  const CustomSearchSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSliverDelegate(
      floating: true,
      height: 90,
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 30,
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0xFFF1F1F3),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
