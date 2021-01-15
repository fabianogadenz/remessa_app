import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/create_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction.dart';
import 'package:remessa_app/v2/modules/transaction/domain/repositories/transaction_repository.dart';
import 'package:remessa_app/v2/modules/transaction/domain/usecases/create_transaction.dart';

import '../../../../../../mocks/modules/transaction/infra/data/repositories/transaction_repository_mock.dart';

main() {
  group('CreateTransaction', () {
    CommandUseCase<CreateTransactionCommand, Future<TransactionEntity>> usecase;
    TransactionRepository repository;

    setUp(() {
      repository = TransactionRepositoryMock();
      usecase = CreateTransaction(repository);
    });

    test('Should return a TransactionModel with correct values on success',
        () async {
      final transactionId = faker.randomGenerator.integer(4);

      final command = CreateTransactionCommand(
        beneficiaryId: faker.randomGenerator.integer(4),
        currencyId: faker.randomGenerator.integer(4),
        currencyAbbreviation: faker.randomGenerator.string(3),
        operationType: faker.randomGenerator.integer(1),
        reverse: faker.randomGenerator.boolean(),
        quantity: faker.randomGenerator.decimal(),
        totalValue: faker.randomGenerator.decimal(),
        voucher: faker.randomGenerator.string(8),
      );

      when(repository.create(any)).thenAnswer(
        (_) async => TransactionEntity(id: transactionId),
      );

      final transaction = await usecase(command);

      expect(transaction.id, transactionId);
    });
  });
}
