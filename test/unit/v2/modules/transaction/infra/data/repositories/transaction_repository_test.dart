import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/v2/core/adapters/http/http_adapter.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/beneficiary.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/currency.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction_confirmation.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction_creation.dart';
import 'package:remessa_app/v2/modules/transaction/domain/repositories/transaction_repository.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/repositories/transaction_repository.dart';

import '../../../../../../../mocks/core/adapters/http_adapter_mock.dart';
import '../../../../../../../mocks/modules/transaction/json/create_transaction_response.dart';

main() {
  group('TransactionRepository', () {
    TransactionRepository repository;
    HttpAdapter httpAdapter;

    setUp(() {
      httpAdapter = HttpAdapterMock();
      repository = TransactionRepositoryImpl(httpAdapter);
    });

    group('create', () {
      TransactionCreationEntity tansactionCreation;

      setUp(() {
        tansactionCreation = TransactionCreationEntity(
          voucher: faker.randomGenerator.string(10),
          quantity: faker.randomGenerator.decimal(),
          operationType: faker.randomGenerator.integer(1),
          reverse: faker.randomGenerator.boolean(),
          totalValue: faker.randomGenerator.decimal(),
          beneficiary: BeneficiaryEntity(
            id: faker.randomGenerator.integer(4),
          ),
          currency: CurrencyEntity(
            id: faker.randomGenerator.integer(4),
            abbreviation: faker.randomGenerator.string(3),
          ),
        );

        when(
          httpAdapter.post(
            any,
            data: {
              'idOperationType': tansactionCreation.operationType,
              'reverse': tansactionCreation.reverse,
              'quantity': tansactionCreation.quantity,
              'totalValue': tansactionCreation.totalValue,
              'idCurrency': tansactionCreation?.currency?.id,
              'abbreviation': tansactionCreation?.currency?.abbreviation,
              'idBeneficiary': tansactionCreation?.beneficiary?.id,
              'voucherCode': tansactionCreation.voucher,
            },
          ),
        ).thenAnswer((_) async => jsonResponse);
      });

      test('Should convert a json to TransactionEntity correctly', () async {
        final transaction = await repository.create(tansactionCreation);

        expect(transaction.id, jsonResponse['id']);
        expect(
          transaction.beneficiary.id,
          jsonResponse['counterpart']['historyId'],
        );
        expect(
          transaction.beneficiary.accountInfo[0].label,
          jsonResponse['counterpart']['accountInfo'][0]['label'],
        );
        expect(transaction.status.id, jsonResponse['statusId']);
        expect(transaction.quote.vet, jsonResponse['quote']['vet']);
        expect(
          transaction.quote.feeTaxes[0].label,
          jsonResponse['quote']['feeTaxes'][0]['label'],
        );
      });
    });

    group('confirm', () {
      TransactionConfirmationEntity transactionConfirmation;

      setUp(() {
        transactionConfirmation = TransactionConfirmationEntity(
          transactionId: faker.randomGenerator.integer(4),
        );

        when(
          httpAdapter.put(
              '/transaction/${transactionConfirmation.transactionId}/confirm'),
        ).thenAnswer((_) async => jsonResponse);
      });

      test('Should not throw errror if run correctly', () {
        expect(
          repository.confirm(transactionConfirmation),
          completion(isNull),
        );
      });
    });
  });
}
