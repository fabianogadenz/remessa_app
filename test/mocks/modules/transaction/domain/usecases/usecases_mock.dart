import 'package:mockito/mockito.dart';
import 'package:remessa_app/v2/modules/transaction/domain/usecases/confirm_transaction.dart';
import 'package:remessa_app/v2/modules/transaction/domain/usecases/create_transaction.dart';

class CreateTransactionMock extends Mock implements CreateTransaction {}

class ConfirmTransactionMock extends Mock implements ConfirmTransaction {}
