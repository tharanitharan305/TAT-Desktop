part of 'Product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProductLoading extends ProductState {}

class ProductUpdating extends ProductState {}

class ProductLoaded extends ProductState {
  final Product product;

  const ProductLoaded({required this.product});

  @override
  List<Object> get props => [product];

  ProductLoaded copyWith({Product? product}) {
    return ProductLoaded(product: product ?? this.product);
  }
}
