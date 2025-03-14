part of 'Product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class UpdateProductField extends ProductEvent {
  final String fieldName;
  final dynamic value;

  const UpdateProductField({required this.fieldName, required this.value});

  @override
  List<Object> get props => [fieldName, value];
}

class SaveProduct extends ProductEvent {
  final Product product;

  const SaveProduct({required this.product});

  @override
  List<Object> get props => [product];
}
