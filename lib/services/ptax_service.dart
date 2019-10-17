import 'dart:convert';

import 'package:remessa_app/models/models.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class PtaxService {
  String _getUrlByDateTime(DateTime dateTime) {
    final dateString = DateFormat('MM-dd-yyyy').format(dateTime);

    return 'https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)?@dataCotacao=%27$dateString%27&\$top=1&\$format=json&\$select=cotacaoCompra';
  }

  Future<double> getDollarValue(DateTime dateTime) async {
    final requestUrl = _getUrlByDateTime(dateTime);

    Response response = await get(requestUrl);

    final ptax = PtaxModel.fromJson(json.decode(response.body));

    return ptax.dollarValue;
  }
}
