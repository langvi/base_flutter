import 'package:base_flutter/base/bloc/base_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class BaseStatefulWidget<SF extends StatefulWidget, B extends BaseBloc>
    extends State<SF> {
  B bloc;
  void initBloc();

  /// init bloc
  void initState() {
    initBloc();
    bloc?.setOnErrorListener(_showErrorBloc);

    super.initState();
  }

  Widget _body;
  PreferredSizeWidget buildAppBar(BuildContext context);
  Widget buildWidgets(BuildContext context);
  Widget buildLoading(BuildContext context);
  Widget buildEmptyPage(BuildContext context);
  @override
  Widget build(BuildContext context) {
    _body = buildWidgets(context);
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<B, dynamic>(
        listener: baseListener,
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            body: _body,
          );
        },
      ),
    );
  }

  void baseListener(BuildContext context, dynamic state);
  void showLoading() {
    _body = buildLoading(context);
    bloc?.updateState();
  }

  void showBody() {
    _body = buildWidgets(context);
    bloc?.updateState();
  }

  void showEmpty() {
    _body = buildEmptyPage(context);
    bloc?.updateState();
  }

  void _showErrorBloc(String error, StackTrace stacktrace) {
    print(stacktrace);
  }
}
