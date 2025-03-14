import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../comapnies.dart';

part 'companyEvent.dart';
part 'companyState.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  Set<String> company_List = {};
  String company = "--select--";
  CompanyBloc() : super(CompanyLoading()) {
    on<FetchCompanyEvent>(_onFetchCompanyEvent);
    on<UpdateCompanyEvent>(_onUpdateCompanyEvent);
  }
  _onFetchCompanyEvent(
      FetchCompanyEvent event, Emitter<CompanyState> emit) async {
    log("hai");
    emit(CompanyLoading());
    try {
      final temp = await Companies().GetCompany();
      company_List = temp;
    } catch (e) {
      emit(CompanyFetchError(message: e.toString()));
    }
    emit(CompanyFetchSucess(company_set: company_List));
    log("complete");
  }

  _onUpdateCompanyEvent(UpdateCompanyEvent event, Emitter<CompanyState> emit) {
    company = event.company;
  }
}
