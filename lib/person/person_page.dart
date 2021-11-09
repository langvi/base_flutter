// import 'package:base_flutter/base/widgets/base_stateful.dart';
// import 'package:base_flutter/person/bloc/person_bloc.dart';
// import 'package:flutter/material.dart';

// class PersonPage extends StatefulWidget {
//   PersonPage({Key key}) : super(key: key);

//   @override
//   _PersonPageState createState() => _PersonPageState();
// }

// class _PersonPageState extends BaseStatefulWidget<PersonPage, PersonBloc> {
//   @override
//   void initBloc() {
//     bloc = PersonBloc();
//     bloc.add(ActionDemo());
//   }

//   @override
//   void baseListener(BuildContext context, state) {
//     if (state is Loading) {
//       showLoading();
//     } else if (state is Success) {
//       showBody();
//     }
//   }

//   @override
//   PreferredSizeWidget buildAppBar(BuildContext context) {
//     return AppBar(
//       title: Text('New page'),
//     );
//   }

//   @override
//   Widget buildEmptyPage(BuildContext context) {
//     return Container();
//   }

//   @override
//   Widget buildLoading(BuildContext context) {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }

//   @override
//   Widget buildBody(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [Text('NEw page')],
//       ),
//     );
//   }
// }
