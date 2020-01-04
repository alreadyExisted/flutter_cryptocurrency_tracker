import 'package:flutter/material.dart';

import 'package:flutter_cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:flutter_cryptocurrency_tracker/screens/home/home_state.dart';

import './home_model.dart';
import './home_event.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final model = HomeModel();

  @override
  void initState() {
    model.dispatch(FetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cryptocurrency Tracker')),
      body: Container(
        child: StreamBuilder(
          stream: model.homeState,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _getInformationMessage(snapshot.error);
            }

            var homeState = snapshot.data;

            if (!snapshot.hasData || homeState is BusyHomeState) {
              return Center(child: CircularProgressIndicator());
            }

            if (homeState is DataFetchedHomeState && !homeState.hasData) {
              return _getInformationMessage('No data found.');
            }

            return ListView.builder(
                itemCount: homeState.data.length,
                itemBuilder: (buildContext, index) =>
                    _getListItem(index, homeState.data));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => model.dispatch(FetchEvent(hasData: true)),
      ),
    );
  }

  Widget _getInformationMessage(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[500]),
      ),
    );
  }

  Widget _getListItem(int index, List<Cryptocurrency> listItems) {
    final item = listItems[index];
    return ListTile(
      title: Text(item.symbol),
      subtitle: Text(item.name),
      leading: CircleAvatar(
        child: Text(item.rank.toString()),
      ),
      trailing: Text('\$${item.price.toString()}'),
    );
  }
}
