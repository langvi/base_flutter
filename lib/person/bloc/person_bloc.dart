import 'dart:async';

import 'package:base_flutter/base/bloc/base_bloc.dart';
import 'package:base_flutter/demo/bloc/demo_bloc.dart';
import 'package:equatable/equatable.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends BaseBloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonInitial());

  @override
  Stream<PersonState> mapEventToState(
    PersonEvent event,
  ) async* {
    if (event is ActionDemo) {
      yield Loading();
      await Future.delayed(Duration(seconds: 2));
      yield Success();
    }
  }

  @override
  void updateState() {
    emit(PersonInitial());
  }
}
