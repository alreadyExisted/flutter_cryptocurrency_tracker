import 'dart:async';

import 'package:flutter_cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:flutter_cryptocurrency_tracker/services/api/cryptocurrency/listings.dart';

import './home_state.dart';
import './home_event.dart';

enum HomeViewState { Busy, DataRetrieved, NoData }

class HomeModel {
  final StreamController<HomeState> _stateController =
      StreamController<HomeState>();

  List<Cryptocurrency> _listItems;

  Stream<HomeState> get homeState => _stateController.stream;

  void dispatch(HomeEvent event) {
    print('Event dispatched: $event');
    if (event is FetchEvent) {
      _getListData(hasError: event.hasError, hasData: event.hasData);
    }
  }

  Future _getListData({bool hasError = false, bool hasData = true}) async {
    _stateController.add(BusyHomeState());

    var fetchedList = await fetchCryptocurrencies();

    if (hasError) {
      return _stateController.addError(
          'An Error occurred while fetching the data. Please try again later.');
    }

    if (!hasData) {
      return _stateController
          .add(DataFetchedHomeState(data: List<Cryptocurrency>()));
    }

    _listItems = fetchedList;
    _stateController.add(DataFetchedHomeState(data: _listItems));
  }
}
