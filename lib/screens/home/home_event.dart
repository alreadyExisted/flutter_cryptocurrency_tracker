class HomeEvent {}

class FetchEvent extends HomeEvent {
  final bool hasError;
  final bool hasData;

  FetchEvent({this.hasError = false, this.hasData = true});

  @override
  String toString() {
    return 'FetchData: { hasError: $hasError, hasData: $hasData }';
  }
}
