import 'package:base_flutter/base/widgets/base_stateful.dart';
import 'package:base_flutter/demo/bloc/demo_bloc.dart';
import 'package:base_flutter/person/person_page.dart';
import 'package:base_flutter/utils/navigator.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  DemoPage({Key key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends BaseStatefulWidget<DemoPage, DemoBloc> {
  int count = 0;
  @override
  void initBloc() {
    bloc = DemoBloc();
  }

  @override
  void baseListener(BuildContext context, state) {
    if (state is Loading) {
      showLoading();
    } else if (state is Empty) {
      showEmpty();
    } else if (state is Success) {
      count++;
      showBody();
    }
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Demo base flutter'),
    );
  }

  @override
  Widget buildEmptyPage(BuildContext context) {
    return Center(
      child: Text('Empty...'),
    );
  }

  @override
  Widget buildLoading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('Value count = $count'),
          ),
          RaisedButton(
            onPressed: () {
              bloc.add(Counter());
            },
            child: Text('Count'),
          ),
          RaisedButton(
            onPressed: () {
              navToScreenWithTransition(context: context, toPage: PersonPage());
            },
            child: Text('To Screen >'),
          )
        ],
      ),
    );
  }
}
