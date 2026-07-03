// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Total spent:`
  String get totalSpent {
    return Intl.message('Total spent:', name: 'totalSpent', desc: '', args: []);
  }

  /// `Official rate: {officialRate} BYN`
  String officialRateXXXByn(Object officialRate) {
    return Intl.message(
      'Official rate: $officialRate BYN',
      name: 'officialRateXXXByn',
      desc: '',
      args: [officialRate],
    );
  }

  /// `EXPENSES`
  String get expenses {
    return Intl.message('EXPENSES', name: 'expenses', desc: '', args: []);
  }

  /// `Failed to load currency rates.`
  String get currencyRatesFailed {
    return Intl.message(
      'Failed to load currency rates.',
      name: 'currencyRatesFailed',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Spent: {spent} {abbreviation}`
  String spentInXXXCurr(Object spent, Object abbreviation) {
    return Intl.message(
      'Spent: $spent $abbreviation',
      name: 'spentInXXXCurr',
      desc: '',
      args: [spent, abbreviation],
    );
  }

  /// `Total Travel Expenses`
  String get totalTravelExpenses {
    return Intl.message(
      'Total Travel Expenses',
      name: 'totalTravelExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Add Expense to {abbreviation}`
  String abbreviation(Object abbreviation) {
    return Intl.message(
      'Add Expense to $abbreviation',
      name: 'abbreviation',
      desc: '',
      args: [abbreviation],
    );
  }

  /// `(+)`
  String get expense {
    return Intl.message('(+)', name: 'expense', desc: '', args: []);
  }

  /// `(-)`
  String get subtract {
    return Intl.message('(-)', name: 'subtract', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Food`
  String get food {
    return Intl.message('Food', name: 'food', desc: '', args: []);
  }

  /// `Transport`
  String get transport {
    return Intl.message('Transport', name: 'transport', desc: '', args: []);
  }

  /// `Housing`
  String get housing {
    return Intl.message('Housing', name: 'housing', desc: '', args: []);
  }

  /// `USA`
  String get USA {
    return Intl.message('USA', name: 'USA', desc: '', args: []);
  }

  /// `EU`
  String get EU {
    return Intl.message('EU', name: 'EU', desc: '', args: []);
  }

  /// `Vietnam`
  String get vietnam {
    return Intl.message('Vietnam', name: 'vietnam', desc: '', args: []);
  }

  /// `Japan`
  String get japan {
    return Intl.message('Japan', name: 'japan', desc: '', args: []);
  }

  /// `China`
  String get china {
    return Intl.message('China', name: 'china', desc: '', args: []);
  }

  /// `Kazakhstan`
  String get kazakhstan {
    return Intl.message('Kazakhstan', name: 'kazakhstan', desc: '', args: []);
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Enter the amount`
  String get enterTheAmount {
    return Intl.message(
      'Enter the amount',
      name: 'enterTheAmount',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
