import 'package:bill_splitter/controller/checkbox_controller.dart';
import 'package:bill_splitter/model/bill/bill_model.dart';
import 'package:bill_splitter/model/user/user_list_model.dart';
import 'package:bill_splitter/model/user/user_model.dart';
import 'package:bill_splitter/utils/formatter.dart';
import 'package:flutter/material.dart';

class FormItemController {
  final List<User> _users = UserListModel().getUsers();
  final Map<String, dynamic> _states = {};
  static bool tip = false;
  final _formatter = Formatter();

  String getTotalBillWithoutTip() {
    double totalValue = 0.0;
    for (var item in Bill().getBillList()) {
      totalValue += item.itemValue;
    }
    return _formatter.formatCurrencyNumber(totalValue);
  }

  String getTotalBillWithTip() {
    double totalValue = 0.0;
    for (var item in Bill().getBillList()) {
      totalValue += item.itemValue;
    }
    if (tip) {
      totalValue = totalValue + (totalValue / 10);
    }
    return _formatter.formatCurrencyNumber(totalValue);
  }

  double getUserBillWithoutTip(String userName) {
    double totalValue = 0;
    for (var item in Bill().getBillList()) {
      for (var user in item.users) {
        user.name == userName
            ? totalValue += item.itemValue / item.users.length
            : null;
      }
    }

    return totalValue;
  }

  double getUserBillWithTip(String userName) {
    double totalValue = getUserBillWithoutTip(userName);
    if (tip) {
      totalValue = totalValue + (totalValue / 10);
    }
    return totalValue;
  }

  Text getValueFromUserIndex(int index) {
    final double userBillValueWithTip = getUserBillWithTip(_users[index].name);
    final double userBillValueWithoutTip =
        getUserBillWithoutTip(_users[index].name);
    String bodyText = '';
    for (var item in Bill().getBillList()) {
      if (item.users.contains(_users[index])) {
        double userValue = item.itemValue / item.users.length;
        bodyText +=
            '${item.itemLabel}:${_formatter.formatCurrencyNumber(userValue)}\n';
      }
    }
    if (tip) {
      bodyText +=
          '10%: ${_formatter.formatCurrencyNumber(userBillValueWithoutTip / 10)}\n';
    }
    String totalText =
        'Total: ${_formatter.formatCurrencyNumber(userBillValueWithTip)}';
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: bodyText,
      ),
      TextSpan(
          text: totalText,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
              height: 1.8)),
    ]));
  }

  Map<String, dynamic> getStates() {
    for (var user in _users) {
      _states[user.name] = {
        'name': user.name,
        'controller': CheckboxController(),
        'object': user
      };
    }
    return _states;
  }

  List<User> getUserList() {
    final List<User> selectedUsers = [];
    for (var user in _users) {
      if (_states[user.name]['controller'].getValue()) {
        selectedUsers.add(_states[user.name]['object']);
      }
    }
    return selectedUsers;
  }

  double? convertNumberStringToValue(String text) {
    double? parsedItem = double.tryParse(
      text.replaceAll(RegExp(r"\D"), ""),
    );
    return parsedItem! / 100;
  }

  void changeTip() {
    tip = !tip;
  }

  bool getTip() {
    return tip;
  }
}
