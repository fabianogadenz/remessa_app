import 'package:easy_i18n/easy_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/actions/action.dart';
import 'package:remessa_app/constants.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';

class AddressMissingFieldsAction extends LinkAction {
  AddressMissingFieldsAction(Beneficiary beneficiary)
      : super(
          name:
              GetIt.I<I18n>().trans('info', ['addressMissingFields', 'action']),
          url:
              '${GetIt.I<Constants>().url}/app/dados-beneficiario/${beneficiary?.idOperationType}/?beneficiaryId=${beneficiary.id}',
          prevAction: () {
            TrackEvents.log(TrackEvents.BENEFICIARY_ADD_ADDRESS_CLICK);
          },
        );
}
