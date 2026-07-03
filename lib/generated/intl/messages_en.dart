// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(abbreviation) => "Add Expense to ${abbreviation}";

  static String m1(officialRate) => "Official rate: ${officialRate} BYN";

  static String m2(spent, abbreviation) => "Spent: ${spent} ${abbreviation}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "EU": MessageLookupByLibrary.simpleMessage("EU"),
    "USA": MessageLookupByLibrary.simpleMessage("USA"),
    "abbreviation": m0,
    "amount": MessageLookupByLibrary.simpleMessage("Amount"),
    "apply": MessageLookupByLibrary.simpleMessage("Apply"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "category": MessageLookupByLibrary.simpleMessage("Category"),
    "china": MessageLookupByLibrary.simpleMessage("China"),
    "currencyRatesFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to load currency rates.",
    ),
    "enterTheAmount": MessageLookupByLibrary.simpleMessage("Enter the amount"),
    "expense": MessageLookupByLibrary.simpleMessage("(+)"),
    "expenses": MessageLookupByLibrary.simpleMessage("EXPENSES"),
    "food": MessageLookupByLibrary.simpleMessage("Food"),
    "housing": MessageLookupByLibrary.simpleMessage("Housing"),
    "japan": MessageLookupByLibrary.simpleMessage("Japan"),
    "kazahstan": MessageLookupByLibrary.simpleMessage("Kazakhstan"),
    "officialRateXXXByn": m1,
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "spentInXXXCurr": m2,
    "subtract": MessageLookupByLibrary.simpleMessage("(-)"),
    "totalSpent": MessageLookupByLibrary.simpleMessage("Total spent:"),
    "totalTravelExpenses": MessageLookupByLibrary.simpleMessage(
      "Total Travel Expenses",
    ),
    "transport": MessageLookupByLibrary.simpleMessage("Transport"),
    "vietnam": MessageLookupByLibrary.simpleMessage("Vietnam"),
  };
}
