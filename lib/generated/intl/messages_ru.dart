// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(abbreviation) => "Добавить трату в ${abbreviation}";

  static String m1(officialRate) => "Официальный курс: ${officialRate} BYN";

  static String m2(spent, abbreviation) =>
      "Потрачено: ${spent} ${abbreviation}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "EU": MessageLookupByLibrary.simpleMessage("ЕС"),
    "USA": MessageLookupByLibrary.simpleMessage("США"),
    "abbreviation": m0,
    "amount": MessageLookupByLibrary.simpleMessage("Сумма"),
    "apply": MessageLookupByLibrary.simpleMessage("Применить"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "category": MessageLookupByLibrary.simpleMessage("Категория"),
    "china": MessageLookupByLibrary.simpleMessage("Китай"),
    "currencyRatesFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить курсы валют.",
    ),
    "enterTheAmount": MessageLookupByLibrary.simpleMessage("Введите сумму"),
    "expense": MessageLookupByLibrary.simpleMessage("(+)"),
    "expenses": MessageLookupByLibrary.simpleMessage("ТРАТЫ"),
    "food": MessageLookupByLibrary.simpleMessage("Еда"),
    "housing": MessageLookupByLibrary.simpleMessage("Жилье"),
    "japan": MessageLookupByLibrary.simpleMessage("Япония"),
    "kazahstan": MessageLookupByLibrary.simpleMessage("Казахстан"),
    "officialRateXXXByn": m1,
    "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "spentInXXXCurr": m2,
    "subtract": MessageLookupByLibrary.simpleMessage("(-)"),
    "totalSpent": MessageLookupByLibrary.simpleMessage("Итого потрачено:"),
    "totalTravelExpenses": MessageLookupByLibrary.simpleMessage(
      "ОБЩИЕ ТРАТЫ ЗА ПОЕЗДКУ",
    ),
    "transport": MessageLookupByLibrary.simpleMessage("Транспорт"),
    "vietnam": MessageLookupByLibrary.simpleMessage("Вьетнам"),
  };
}
