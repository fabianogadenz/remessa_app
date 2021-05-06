import 'package:mobx/mobx.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/settings/application/viewmodels/notification_preferences_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/transaction_viewmodel.dart';

part 'notification_preferences_presenter.g.dart';

class NotificationPreferencesPresenter = _NotificationPreferencesPresenterBase
    with _$NotificationPreferencesPresenter;

abstract class _NotificationPreferencesPresenterBase with Store {
  final CommandUseCase<bool, Future<void>> _enablePushNotification;

  _NotificationPreferencesPresenterBase(
    this._enablePushNotification,
  );

  @observable
  String errorMessage;

  @action
  setErrorMessage(String value) => errorMessage = value;

  @observable
  TransactionViewModel transaction;

  @action
  updateNoficiationPreferences(
      NotificationPreferencesViewModel notificationPreferences) async {
    // try {
    await _enablePushNotification(
      notificationPreferences.enablePushNotification,
    );
    // TODO: Add error handler
    // } on ErrorModel catch (error) {
    //   setErrorMessage(error?.mainError?.message);
    // } on ErrorMessage catch (error) {
    //   setErrorMessage(error.message);
    // }
  }
}
