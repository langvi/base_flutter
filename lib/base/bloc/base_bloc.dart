import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  Function(String error, StackTrace stacktrace) onErrorCallBack;
  BaseBloc(initialState) : super(initialState);

  /// catch lỗi khi gọi đến API sử dụng thư viện Dio
  void setOnErrorListener(
      Function(String error, StackTrace stacktrace) onErrorCallBack) {
    this.onErrorCallBack = onErrorCallBack;
  }

  /// Hàm cập nhật state
  void updateState();
  @override
  Stream<Transition<E, S>> transformEvents(Stream<E> events, transitionFn) {
    return events.flatMap(transitionFn);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    String errorContent =
        'Không thể kết nối tới máy chủ\nQuý khách vui lòng kiểm tra lại kết nối mạng';
    if (error is DioError) {
      if (error.response?.data != null && error.response.data is Map) {
        errorContent = error.response.data['message'];
      } else if (error.type != null) {
        switch (error.type) {
          case DioErrorType.CONNECT_TIMEOUT:
          case DioErrorType.SEND_TIMEOUT:
          case DioErrorType.RECEIVE_TIMEOUT:
            errorContent =
                'Không có phản hồi từ hệ thống, Quý khách vui lòng thử lại sau';
            break;
          case DioErrorType.RESPONSE:
            switch (error.response.statusCode) {
              case 400:
                errorContent = 'Dữ liệu gửi đi không hợp lệ!';
                break;
              case 401:
                errorContent =
                    'Phiên đăng nhập đã hết hạn, quý khách vui lòng đăng nhập lại';
                break;
              case 404:
                errorContent =
                    'Không tìm thấy đường dẫn này, xin vui lòng liên hệ Admin';
                break;
              case 500:
                errorContent =
                    'Lỗi xử lý hệ thống\nXin vui lòng thử lại sau!!!';
                break;
              case 502:
                errorContent =
                    'Server đang bảo trì, Quý khách vui lòng quay lại sau.';
                break;
              case 503:
                errorContent =
                    'Server đang bảo trì, Quý khách vui lòng quay lại sau một vài phút.';
                break;
              default:
                errorContent =
                    'Lỗi xử lý hệ thống\nXin vui lòng thử lại sau!!!';
            }
            break;
          default:
            errorContent =
                'Không thể kết nối tới máy chủ\nQuý khách vui lòng kiểm tra lại kết nối mạng';
        }
      }
    }

    print('errorContent -> $errorContent');
    if (onErrorCallBack != null) onErrorCallBack(errorContent, stacktrace);
    super.onError(error, stacktrace);
  }
}
