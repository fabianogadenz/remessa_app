import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/responses/error_response_model.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/stores/auth_store.dart';

class ErrorHelper {
  static const authStatus = [
    HttpStatus.unauthorized,
    HttpStatus.forbidden,
  ];

  static const timeoutStatus = [
    DioErrorType.CONNECT_TIMEOUT,
    DioErrorType.RECEIVE_TIMEOUT,
    DioErrorType.SEND_TIMEOUT
  ];

  static const serverErrorStatus = [
    HttpStatus.serviceUnavailable,
    HttpStatus.internalServerError,
  ];

  static List<ErrorResponseModel> parseErrorResponse(DioError error) =>
      hasListResponseData(error)
          ? error.response.data
              .map<ErrorResponseModel>(
                (data) => ErrorResponseModel.fromJson(data),
              )
              .toList()
          : [];

  static formatError(List<ErrorResponseModel> errors) {
    ErrorResponseModel mainError;
    List<ErrorResponseModel> fieldErrors = [];

    errors.forEach((error) {
      if (error.field == null) {
        mainError = error;
        return;
      }

      fieldErrors.add(error);
    });

    return ErrorModel(
      mainError: mainError,
      fieldErrors: fieldErrors,
    );
  }

  static parseAndFormatErrorResponse(DioError error) =>
      formatError(parseErrorResponse(error));

  static hasListResponseData(DioError error) =>
      (error?.response?.data != null && error?.response?.data is List);

  static throwFormattedErrorResponse(DioError error) =>
      hasListResponseData(error)
          ? throw parseAndFormatErrorResponse(error)
          : throw error;

  static requestRetry(DioError dioError) async {
    final dio = GetIt.I<Dio>();

    final request = dioError.request;
    final extra = dioError.request.extra;

    if (!extra.containsKey('retries')) {
      extra['retries'] = 3;
    }

    try {
      if (extra['retries'] > 0) {
        extra['retries']--;
        return await dio.request<dynamic>(
          request.path,
          data: request.data,
          queryParameters: request.queryParameters,
          options: Options(
            method: request.method,
            headers: request.headers,
            extra: extra,
          ),
        );
      }
    } catch (e) {
      return e;
    }
  }

  static dioErrorInterceptor(DioError dioError) async {
    final i18n = GetIt.I<I18n>();
    final _authStore = GetIt.I<AuthStore>();

    if (serverErrorStatus.contains(dioError.response?.statusCode)) {
      await _authStore.logout();

      return DioError(
        error: i18n.trans('error', ['internal_server']),
      );
    }

    if (dioError.error is SocketException) {
      await requestRetry(dioError);

      return DioError(
        error: i18n.trans('error', ['network_connection']),
      );
    }

    if (timeoutStatus.contains(dioError.type)) {
      await requestRetry(dioError);

      return DioError(
        error: i18n.trans('error', ['request_timeout']),
      );
    }

    if (authStatus.contains(dioError.response?.statusCode) &&
        GetIt.I<AuthService>().token != null) {
      await _authStore.logout();

      return DioError(
        error: i18n.trans('error', ['auth_expired']),
      );
    }

    return dioError;
  }
}
