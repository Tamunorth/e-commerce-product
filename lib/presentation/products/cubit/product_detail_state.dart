import '../../../domain/entities/product.dart';

sealed class ProductDetailState {
  const ProductDetailState();
}

class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial();
}

class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();
}

class ProductDetailLoaded extends ProductDetailState {
  const ProductDetailLoaded(this.product);
  final Product product;
}

class ProductDetailError extends ProductDetailState {
  const ProductDetailError(this.message);
  final String message;
}
