import 'package:dio/dio.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/responses/error_response_model.dart';

class ErrorHelper {
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
}
