// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuoteStore on _QuoteStoreBase, Store {
  final _$quoteAtom = Atom(name: '_QuoteStoreBase.quote');

  @override
  Quote get quote {
    _$quoteAtom.context.enforceReadPolicy(_$quoteAtom);
    _$quoteAtom.reportObserved();
    return super.quote;
  }

  @override
  set quote(Quote value) {
    _$quoteAtom.context.conditionallyRunInAction(() {
      super.quote = value;
      _$quoteAtom.reportChanged();
    }, _$quoteAtom, name: '${_$quoteAtom.name}_set');
  }

  final _$_QuoteStoreBaseActionController =
      ActionController(name: '_QuoteStoreBase');

  @override
  dynamic setQuote(Quote value) {
    final _$actionInfo = _$_QuoteStoreBaseActionController.startAction();
    try {
      return super.setQuote(value);
    } finally {
      _$_QuoteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'quote: ${quote.toString()}';
    return '{$string}';
  }
}
