import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/models/requests/simulator_request_model.dart';
import 'package:remessa_app/models/responses/simulator_default_values_response_model.dart';
import 'package:remessa_app/models/responses/simulator_response_model.dart';

class SimulatorService {
  static final options = Options(sendTimeout: 200, receiveTimeout: 200);

  static getDefaultValues(
      int beneficiaryId, int currencyId, String currencyAbbreviation) async {
    try {
      Response response = await GetIt.I<Dio>().get(
        '/simulator',
        queryParameters: {
          'idBeneficiary': beneficiaryId,
          'idCurrency': currencyId,
          'abbreviation': currencyAbbreviation,
        },
      );

      return SimulatorDefaultValuesResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static simulate(SimulatorRequestModel data) async {
    try {
      Response response = await GetIt.I<Dio>().post(
        '/simulator',
        data: data.toJson(),
        options: options,
      );

      return SimulatorResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }
  }
}
