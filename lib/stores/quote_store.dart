import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/quote_model.dart';
part 'quote_store.g.dart';

class QuoteStore = _QuoteStoreBase with _$QuoteStore;

abstract class _QuoteStoreBase with Store {
  @observable
  Quote quote;

  @action
  setQuote(Quote value) => quote = value;
}
