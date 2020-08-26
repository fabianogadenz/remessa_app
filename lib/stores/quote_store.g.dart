// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuoteStore on _QuoteStoreBase, Store {
  final _$quoteAtom = Atom(name: '_QuoteStoreBase.quote');

  @override
  Quote get quote {
    _$quoteAtom.reportRead();
    return super.quote;
  }

  @override
  set quote(Quote value) {
    _$quoteAtom.reportWrite(value, super.quote, () {
      super.quote = value;
    });
  }

  final _$_QuoteStoreBaseActionController =
      ActionController(name: '_QuoteStoreBase');

  @override
  dynamic setQuote(Quote value) {
    final _$actionInfo = _$_QuoteStoreBaseActionController.startAction(
        name: '_QuoteStoreBase.setQuote');
    try {
      return super.setQuote(value);
    } finally {
      _$_QuoteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quote: ${quote}
    ''';
  }
}
