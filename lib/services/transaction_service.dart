import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';
import 'package:remessa_app/models/responses/transaction_response_model.dart';
import 'package:remessa_app/services/auth_service.dart';

enum Flow {
  OUTBOUND,
  INBOUND,
}

enum StatusType {
  OPEN,
  FINISHED,
}

class TransactionService {
  static String flowToString(Flow flow) {
    switch (flow) {
      case Flow.OUTBOUND:
        return 'OUTBOUND';
      case Flow.INBOUND:
        return 'INBOUND';
      default:
        return '';
    }
  }

  static String statusTypeToString(StatusType statusType) {
    switch (statusType) {
      case StatusType.OPEN:
        return 'OPEN';
      case StatusType.FINISHED:
        return 'FINISHED';
      default:
        return '';
    }
  }

  static getTransactions({
    StatusType statusType,
    Flow flow,
    int page,
  }) async {
    try {
      final token = GetIt.I<AuthService>().token;

      Response response = await GetIt.I<Dio>().get(
        '/transaction',
        queryParameters: {
          'filter': {
            'statusType': statusTypeToString(statusType),
            'flow': flowToString(flow),
          },
          'page': page,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return TransactionResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }
  }

  static getTransactionDetailsById(int transactionId) async {
    try {
      final token = GetIt.I<AuthService>().token;

      Response response = await GetIt.I<Dio>().get(
        '/transaction/$transactionId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return TransactionDetailsResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }
  }
}
