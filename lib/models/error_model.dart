import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:remessa_app/models/responses/error_response_model.dart';

class ErrorModel extends Equatable {
  final ErrorResponseModel mainError;
  final List<ErrorResponseModel> fieldErrors;

  ErrorModel({
    @required this.mainError,
    @required this.fieldErrors,
  }) : assert(mainError != null);

  @override
  List<Object> get props => [mainError, fieldErrors];
}
