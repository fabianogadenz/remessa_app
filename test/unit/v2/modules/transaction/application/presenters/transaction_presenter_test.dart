import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/transaction/application/presenters/transaction_presenter.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/transaction_creation_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/transaction_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/confirm_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/create_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction.dart';

import '../../../../../../mocks/modules/transaction/domain/usecases/usecases_mock.dart';

main() {
  group('TransactionPresenter', () {
    CommandUseCase<CreateTransactionCommand, Future<TransactionEntity>>
        createTransactionUseCase;
    CommandUseCase<ConfirmTransactionCommand, Future<void>>
        confirmTransactionUseCase;
    TransactionPresenter transactionPresenter;

    setUp(() {
      createTransactionUseCase = CreateTransactionMock();
      confirmTransactionUseCase = ConfirmTransactionMock();
      transactionPresenter = TransactionPresenter(
        createTransactionUseCase,
        confirmTransactionUseCase,
      );
    });

    group('createTransaction', () {
      test('Should populate transaction when create is called successfully',
          () async {
        final transactionId = faker.randomGenerator.integer(4);

        final transactionCreation = TransactionCreationViewModel(
          beneficiaryId: faker.randomGenerator.integer(4),
          currencyId: faker.randomGenerator.integer(4),
          currencyAbbreviation: faker.randomGenerator.string(3),
          operationType: faker.randomGenerator.integer(1),
          reverse: faker.randomGenerator.boolean(),
          quantity: faker.randomGenerator.decimal(),
          totalValue: faker.randomGenerator.decimal(),
          voucher: faker.randomGenerator.string(8),
        );

        when(createTransactionUseCase.call(any)).thenAnswer(
          (_) async => TransactionEntity(id: transactionId),
        );

        expect(transactionPresenter.transaction, null);

        await transactionPresenter.createTransaction(transactionCreation);

        expect(transactionPresenter.transaction.id, transactionId);
      });
    });

    group('confirmTransaction', () {
      test('if confirmation succeeds, error should be empty', () async {
        final transactionId = faker.randomGenerator.integer(4);

        transactionPresenter.transaction =
            TransactionViewModel(id: transactionId);

        when(confirmTransactionUseCase.call(any)).thenAnswer(
          (_) async => TransactionEntity(id: transactionId),
        );

        await transactionPresenter.confirmTransaction();

        expect(transactionPresenter.errorMessage, null);
      });
    });
  });
}
