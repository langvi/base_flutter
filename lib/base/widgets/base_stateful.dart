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

  // view hiện tại của page
  // _body phải !=null
  Widget _body;

  /// Appbar page
  ///
  /// return null khi muốn ẩn appbar
  PreferredSizeWidget buildAppBar(BuildContext context);

  /// Giao diện chính của page
  Widget buildBody(BuildContext context);

  /// Giao diện loading
  Widget buildLoading(BuildContext context);

  /// Giao diện page trống hoặc lỗi khi lấy dữ liệu
  Widget buildEmptyPage(BuildContext context);
  @override
  Widget build(BuildContext context) {
    _body = buildBody(context);
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

  /// override lại hàm listener của bloc để lắng nghe sự thay đổi dữ liệu
  void baseListener(BuildContext context, dynamic state);

  /// gọi đến hàm này để show lên giao diện loading đã xây dựng ở trên
  void showLoading() {
    _body = buildLoading(context);
    bloc?.updateState();
  }

  /// gọi đến giao diện chính của page
  ///
  /// Mặc định sẽ để view là giao diện này
  void showBody() {
    _body = buildBody(context);
    bloc?.updateState();
  }

  /// Gọi đến giao diện trống hoặc không mong muốn
  ///
  /// Nên sử dụng khi get dữ liệu từ API
  ///
  /// Mặc định nên trả về 1 widget !=null
  void showEmpty() {
    _body = buildEmptyPage(context);
    bloc?.updateState();
  }

  void _showErrorBloc(String error, StackTrace stacktrace) {
    print(stacktrace);
  }
}
