import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/confirm_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/payment_account_info.dart';
import 'package:remessa_app/v2/modules/transaction/domain/repositories/transaction_repository.dart';
import 'package:remessa_app/v2/modules/transaction/domain/usecases/confirm_transaction.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/models/payment_account_info_model.dart';

import '../../../../../../mocks/modules/settings/infra/data/repositories/repositories_mock.dart';

main() {
  group('ConfirmTransaction', () {
    CommandUseCase<ConfirmTransactionCommand, Future<PaymentAccountInfoEntity>>
        usecase;
    TransactionRepository repository;

    setUp(() {
      repository = TransactionRepositoryMock();
      usecase = ConfirmTransaction(repository);
    });

    test('Should return without throw', () async {
      final accountNumber = faker.randomGenerator.string(6);

      final command = ConfirmTransactionCommand(
        transactionId: faker.randomGenerator.integer(4),
      );

      when(repository.confirm(any)).thenAnswer(
        (_) async => PaymentAccountInfoModel.fromJson({
          'accountNumber': accountNumber,
        }),
      );

      final paymentAccountInfo = await usecase(command);

      expect(paymentAccountInfo.accountNumber, accountNumber);
    });
  });
}
