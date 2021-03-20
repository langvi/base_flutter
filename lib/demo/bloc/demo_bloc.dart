import 'dart:async';

import 'package:base_flutter/base/bloc/base_bloc.dart';
import 'package:equatable/equatable.dart';

part 'demo_event.dart';
part 'demo_state.dart';

class DemoBloc extends BaseBloc<DemoEvent, DemoState> {
  DemoBloc() : super(DemoInitial());

  @override
  Stream<DemoState> mapEventToState(
    DemoEvent event,
  ) async* {
    if (event is Counter) {
      print('loading');

      yield Loading();

      await Future.delayed(Duration(seconds: 2));
      print('empty');
      yield Empty();
      await Future.delayed(Duration(seconds: 2));
       print('success');
      yield Success();
    }
  }

  @override
  void updateState() {
    emit(DemoInitial());
  }
}
