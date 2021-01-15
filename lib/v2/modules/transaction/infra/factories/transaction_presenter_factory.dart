import 'package:remessa_app/v2/core/adapters/http/http_adapter_dio.dart';
import 'package:remessa_app/v2/core/factory/factory.dart';
import 'package:remessa_app/v2/modules/transaction/application/presenters/transaction_presenter.dart';
import 'package:remessa_app/v2/modules/transaction/domain/usecases/create_transaction.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/repositories/transaction_repository.dart';

class TransactionPresenterFactory implements Factory<TransactionPresenter> {
  @override
  TransactionPresenter call() {
    return TransactionPresenter(
      CreateTransaction(
        TransactionRepositoryImpl(
          HttpAdapterDio(),
        ),
      ),
    );
  }
}
