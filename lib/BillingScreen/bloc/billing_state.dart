

part of 'billing_bloc.dart';

@immutable
sealed class BillingState extends Equatable {
  const BillingState();
  @override
  List<Object> get props => [];
}

class BillingLoding extends BillingState {
  const BillingLoding();
}

class BillingError extends BillingState {
  final String message;
  const BillingError({required this.message});
}

class BillingSucess extends BillingState {
  const BillingSucess();
}
class BillingComplete extends BillingState{}