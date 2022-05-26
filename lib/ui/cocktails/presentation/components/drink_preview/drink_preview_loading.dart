import 'package:flutter/material.dart';
import 'package:flutter_cocktail_app/ui/widgets/shimmer_loading.dart';

class DrinkPreviewLoading extends StatelessWidget {
  const DrinkPreviewLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerLoading(
          height: 200,
          borderRadius: 20,
        ),
        const SizedBox(height: 20),
        const ShimmerLoading(height: 30),
        const SizedBox(height: 10),
        const ShimmerLoading(
          height: 30,
          width: 60,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[
              const Align(
                widthFactor: .6,
                child: ShimmerLoading(
                  width: 40,
                  height: 40,
                  borderRadius: 30,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 20),
        const ShimmerLoading(
          height: 50,
          borderRadius: 10,
        ),
      ],
    );
  }
}
