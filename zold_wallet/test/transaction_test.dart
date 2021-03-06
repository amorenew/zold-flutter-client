
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:zold_wallet/transaction.dart';

import 'transaction_data.dart';

void main() {
  final Map<String, dynamic> values = <String, dynamic>{};
  values['id'] = 123;
  values['date'] = '2019-04-07T07:42:57Z';
  values['amount'] = 12;
  values['details'] = 'test';
  values['bnf'] = '25a9cac1715a3726';
  final Transaction t1 = Transaction.fromJson(values);
  values['date'] = '2020-04-07T07:42:57Z';
  final Transaction t2 = Transaction.fromJson(values);
  /// test comparing a transaction as after another one.
  test('test is after', () {
    expect(t1.isAfter(t2), false);
  });

  /// test the created list out of response 
  /// is successfully created and ordered correctly.
  test('test creating list', () {
    final List<dynamic> map = json.decode(TransactionData.listStringDumb);
    expect(map, isNotNull);
    Transaction last = Transaction.fromJson(map[0]);
    for (int i = 1; i < map.length; i++) {
      final Transaction t = Transaction.fromJson(map[i]);
      expect(t.isAfter(last), false);
      last = t;
    }
    final List<Transaction> transactionList = Transaction.fromJsonList(map);
    expect(transactionList.length, isNonZero);
    for(int i=0; i<transactionList.length-1; i++) {
      expect(transactionList[i+1].isAfter(transactionList[i]), false);
    }
  });
}