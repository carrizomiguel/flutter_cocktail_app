import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cocktail_app/ui/app/presentation/components/repository_bridge.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/repositories/cocktails_repository.dart';
import 'package:flutter_cocktail_app/ui/cocktails/presentation/bloc/cocktails_bloc.dart';
import 'package:flutter_cocktail_app/ui/home/home.dart';

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryBridge(
      child: const AppBody(),
    );
  }
}

class AppBody extends StatelessWidget {
  const AppBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => CocktailsBloc(
        repository: context.read<CocktailsRepositoryImpl>(),
      )..add(CocktailsGetCategories()),
      child: const MaterialApp(
        title: 'Cocktails',
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        home: HomePage(),
      ),
    );
  }
}
