import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/usecases/get_categories.dart';

class CategoriesState extends Equatable {
  const CategoriesState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
  });

  final List<Category> categories;
  final bool isLoading;
  final String? error;

  CategoriesState copyWith({
    List<Category>? categories,
    bool? isLoading,
    String? Function()? error,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [categories, isLoading, error];
}

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._getCategories) : super(const CategoriesState());

  final GetCategories _getCategories;

  Future<void> loadCategories() async {
    emit(state.copyWith(isLoading: true));
    try {
      final categories = await _getCategories();
      emit(state.copyWith(
        categories: categories,
        isLoading: false,
        error: () => null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: () => e.toString(),
      ));
    }
  }
}
