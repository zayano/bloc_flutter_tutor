part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorSuccess extends CalculatorState {
  final int result;

  CalculatorSuccess(this.result);
}

class CalculatorFailed extends CalculatorState {
  final String error;

  CalculatorFailed(this.error);
}
