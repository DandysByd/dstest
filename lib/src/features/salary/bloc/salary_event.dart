part of 'salary_bloc.dart';

sealed class SalaryEvent {
  const SalaryEvent();
}

final class FetchSalaries extends SalaryEvent {}
