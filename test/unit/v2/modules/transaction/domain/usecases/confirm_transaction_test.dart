import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/confirm_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction.dart';
import 'package:remessa_app/v2/modules/transaction/domain/repositories/transaction_repository.dart';
import 'package:remessa_app/v2/modules/transaction/domain/usecases/confirm_transaction.dart';

import '../../../../../../mocks/modules/settings/infra/data/repositories/repositories_mock.dart';

main() {
  group('ConfirmTransaction', () {
    CommandUseCase<ConfirmTransactionCommand, Future<void>> usecase;
    TransactionRepository repository;

    setUp(() {
      repository = TransactionRepositoryMock();
      usecase = ConfirmTransaction(repository);
    });

    test('Should return without throw', () async {
      final transactionId = faker.randomGenerator.integer(4);

      final command = ConfirmTransactionCommand(
        transactionId: faker.randomGenerator.integer(4),
      );

      when(repository.confirm(any)).thenAnswer(
        (_) async => TransactionEntity(id: transactionId),
      );

      expect(usecase(command), completion(isNull));
    });
  });
}
