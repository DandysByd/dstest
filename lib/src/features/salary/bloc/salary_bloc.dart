import 'package:dstest/src/features/salary/bloc/salary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/salary.service.dart';

part 'salary_event.dart';

class SalaryBloc extends Bloc<SalaryEvent, SalaryState> {
  final SalaryService salaryService = SalaryService();

  SalaryBloc() : super(const SalaryState()) {
    on<FetchSalaries>(_onFetchSalaries);
  }

  Future<void> _onFetchSalaries(
      FetchSalaries event, Emitter<SalaryState> emit) async {
    emit(state.copyWith(status: BlocState.loading));
    final salaries = await salaryService.fetchSalaries();
    print(salaries);
    try {
      emit(state.copyWith(
        salaries: salaries,
        status: BlocState.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: BlocState.failure));
    }
  }
}
