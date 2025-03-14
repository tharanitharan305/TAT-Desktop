

part of 'companyBloc.dart';

@immutable
sealed class CompanyState extends Equatable {
  @override
  List<Object> get props => [];
}

class CompanyLoading extends CompanyState {}

class CompanyFetchSucess extends CompanyState {
  Set<String> company_set;
  CompanyFetchSucess({required this.company_set});
}

class CompanyLoadComplete extends CompanyState {}

class CompanyFetchError extends CompanyState {
  String message;
  CompanyFetchError({required this.message});
}
