import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/drink_model.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/models/short_drink_model.dart';
import 'package:flutter_cocktail_app/ui/cocktails/data/repositories/cocktails_repository.dart';

part 'cocktails_event.dart';
part 'cocktails_state.dart';

class CocktailsBloc extends Bloc<CocktailsEvent, CocktailsState> {
  CocktailsBloc({
    required this.repository,
  }) : super(const CocktailsState()) {
    on<CocktailsGetCategories>(_onGetCategories);
    on<CocktailsGetDrinksByCategory>(_onGetDrinksByCategory);
    on<CocktailsGetDrinkById>(_onGetDrinkById);
  }

  final CocktailsRepository repository;

  String categorySelected = '';
  ShortDrinkModel drinkPreviewSelected = ShortDrinkModel.empty();

  void _onGetCategories(
    CocktailsGetCategories event,
    Emitter emit,
  ) async {
    emit(state.copyWith(
      categoryStatus: CocktailsStatus.loading,

    ));
    final result = await repository.getCategories();
    result.when(
      ok: (list) {
        categorySelected = list.first;
        emit(state.copyWith(
          categoryStatus: CocktailsStatus.success,
          categories: list,
        ));
        add(CocktailsGetDrinksByCategory(
          category: categorySelected,
        ));
      },
      err: (failure) => emit(state.copyWith(
        categoryStatus: CocktailsStatus.error,
      )),
    );
  }

  void _onGetDrinksByCategory(
    CocktailsGetDrinksByCategory event,
    Emitter emit,
  ) async {
    emit(state.copyWith(
      drinksStatus: CocktailsStatus.loading,
    ));
    final result = await repository.getDrinksByCategory(
      event.category,
    );
    result.when(
      ok: (list) {
        drinkPreviewSelected = list.first;
        emit(state.copyWith(
          drinksStatus: CocktailsStatus.success,
          drinks: list,
        ));
        add(CocktailsGetDrinkById(
          id: list.first.idDrink,
        ));
      },
      err: (failure) => emit(state.copyWith(
        drinksStatus: CocktailsStatus.error,
      )),
    );
  }

  void _onGetDrinkById(
    CocktailsGetDrinkById event,
    Emitter emit,
  ) async {
    emit(state.copyWith(
      drinkPreviewStatus: CocktailsStatus.loading,
    ));
    final result = await repository.getDrinkById(
      event.id,
    );
    result.when(
      ok: (drink) {
        drinkPreviewSelected = state.drinks.firstWhere(
          (e) => e.idDrink == event.id,
        );
        emit(state.copyWith(
          drinkPreviewStatus: CocktailsStatus.success,
          drink: drink,
        ));
      },
      err: (failure) => emit(state.copyWith(
        drinkPreviewStatus: CocktailsStatus.error,
      )),
    );
  }
}
