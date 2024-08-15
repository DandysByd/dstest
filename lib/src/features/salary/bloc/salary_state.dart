import 'package:equatable/equatable.dart';

import '../models/salary.model.dart';

enum BlocState { initial, loading, success, failure }

extension Status on BlocState {
  bool get isInitial => this == BlocState.initial;
  bool get isLoading => this == BlocState.loading;
  bool get isSuccess => this == BlocState.success;
  bool get isFailure => this == BlocState.failure;
}

final class SalaryState extends Equatable {
  final List<Salary> salaries;
  final BlocState status;

  const SalaryState(
      {this.salaries = const [], this.status = BlocState.initial});

  SalaryState copyWith({
    List<Salary>? salaries,
    BlocState? status,
  }) {
    return SalaryState(
      salaries: salaries ?? this.salaries,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [salaries, status];
}
