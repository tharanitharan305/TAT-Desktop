
part of 'companyBloc.dart';

@immutable
sealed class CompanyEvent extends Equatable {
  List<Object> get props => [];
}

class FetchCompanyEvent extends CompanyEvent {

}

class UpdateCompanyEvent extends CompanyEvent {
  String company;
  UpdateCompanyEvent({required this.company});
}
