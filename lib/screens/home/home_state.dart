import 'package:flutter_cryptocurrency_tracker/models/cryptocurrency.dart';

class HomeState {}

class InitializedHomeState extends HomeState {}

class DataFetchedHomeState extends HomeState {
  final List<Cryptocurrency> data;

  DataFetchedHomeState({this.data});

  bool get hasData => data.length > 0;
}

class ErrorHomeState extends HomeState {}

class BusyHomeState extends HomeState {}
