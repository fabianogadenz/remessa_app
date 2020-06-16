import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';

class BeneficiaryService {
  static getBeneficiaries() async {
    try {
      Response response = await GetIt.I<Dio>().get('/beneficiary');

      return BeneficiaryResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }
  }
}
