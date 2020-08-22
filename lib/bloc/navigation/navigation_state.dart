import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationSearch extends NavigationState {
  int getIndex() => 0;

  @override
  String toString() => 'NavigationSearch';
}

class NavigationSchedule extends NavigationState {
  int getIndex() => 1;

  @override
  String toString() => 'NavigationSchedule';
}

class NavigationAccount extends NavigationState {
  int getIndex() => 2;

  @override
  String toString() => 'NavigationAccount';
}

class NavigationError extends NavigationState {
  @override
  String toString() => 'NavigationError';
}
