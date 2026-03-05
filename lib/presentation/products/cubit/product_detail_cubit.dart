import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_product_by_id.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit(this._getProductById) : super(const ProductDetailInitial());

  final GetProductById _getProductById;
  int? _lastRequestedId;
  final Map<int, Product> _cache = {};

  Future<void> loadProduct(int id) async {
    _lastRequestedId = id;

    // Return cached product immediately if available
    final cached = _cache[id];
    if (cached != null) {
      emit(ProductDetailLoaded(cached));
      return;
    }

    emit(const ProductDetailLoading());
    try {
      final product = await _getProductById(id);
      _cache[id] = product;
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }

  Future<void> retry() async {
    final id = _lastRequestedId;
    if (id != null) {
      _cache.remove(id);
      await loadProduct(id);
    }
  }
}
