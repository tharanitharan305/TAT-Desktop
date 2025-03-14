part of 'billing_bloc.dart';

@immutable
sealed class BillingEvent extends Equatable {
  const BillingEvent();

  @override
  List<Object> get props => []; // Required for Equatable
}

class FetchShopsEvent extends BillingEvent {
  @override
  List<Object> get props => []; // No additional properties
}

class FetchProductEvent extends BillingEvent {
  // Example property

  const FetchProductEvent();

  @override
  List<Object> get props => [];
}

class UpdateProductsEvent extends BillingEvent {
  final List<Product> products; // Example property

  const UpdateProductsEvent(this.products);

  @override
  List<Object> get props => [products];
}

class SubmitBillEvent extends BillingEvent {
  final int billNumber;

  const SubmitBillEvent(this.billNumber);

  @override
  List<Object> get props => [billNumber];
}

class UpdateShopEvent extends BillingEvent {
  final Shop shop;

  const UpdateShopEvent(this.shop);

  @override
  List<Object> get props => [shop];
}

class FetchBillNumberEvent extends BillingEvent {
  const FetchBillNumberEvent();
}
