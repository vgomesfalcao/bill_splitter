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
  final _formatterWithIcon = Formatter();
  final _formatterWithoutIcon = Formatter();

  String getTotalBillWithoutTip() {
    double totalValue = 0.0;
    for (var item in Bill().getBillList()) {
      totalValue += item.itemValue;
    }
    return _formatterWithIcon.formatCurrencyNumber(number: totalValue);
  }

  String getTotalBillWithTip() {
    double totalValue = getTotalValue();
    if (tip) {
      totalValue = totalValue + (totalValue / 10);
    }
    return _formatterWithIcon.formatCurrencyNumber(number: totalValue);
  }

  double getTotalValue() {
    double totalValue = 0.0;
    for (var item in Bill().getBillList()) {
      totalValue += item.itemValue;
    }
    return totalValue;
  }

  String getTipValue() {
    double totalValue = getTotalValue();
    double tipValue = 0.0;
    if (tip) {
      tipValue = (totalValue / 10);
    }
    return _formatterWithIcon.formatCurrencyNumber(number: tipValue);
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

  String getUserBillWithTipToString(int index) {
    final double userBillValueWithTip = getUserBillWithTip(_users[index].name);
    String userBillWithTip =
        _formatterWithIcon.formatCurrencyNumber(number: userBillValueWithTip);
    return userBillWithTip;
  }

  Column getValueFromUserIndex(int index) {
    MainAxisAlignment alignmentOfText = MainAxisAlignment.spaceBetween;
    TextStyle textStyle = const TextStyle(fontSize: 14, color: Colors.black87);
    final double userBillValueWithoutTip =
        getUserBillWithoutTip(_users[index].name);
    List<Row> itemsText = [];
    Row tipText;
    for (var item in Bill().getBillList()) {
      if (item.users.contains(_users[index])) {
        double userValue = item.itemValue / item.users.length;
        itemsText.add(Row(mainAxisAlignment: alignmentOfText, children: [
          Text(item.itemLabel, style: textStyle),
          Text(
            _formatterWithIcon.formatCurrencyNumber(number: userValue),
            style: textStyle,
          )
        ]));
      }
    }
    if (tip) {
      tipText = Row(
        mainAxisAlignment: alignmentOfText,
        children: [
          Text(
            'Serviço',
            style: textStyle,
          ),
          Text(
              style: textStyle,
              '${_formatterWithoutIcon.formatCurrencyNumber(
                number: userBillValueWithoutTip,
                currencyIcon: false,
              )} x 10,0% = ${_formatterWithIcon.formatCurrencyNumber(number: userBillValueWithoutTip / 10)}')
        ],
      );
    } else {
      tipText = Row(
        mainAxisAlignment: alignmentOfText,
        children: [
          Text(
            'Serviço',
            style: textStyle,
          ),
          Text(
            'R\$ 0,00',
            style: textStyle,
          )
        ],
      );
    }

    return Column(
      children: [
        ...itemsText,
        const Divider(
          color: Colors.black,
        ),
        tipText
      ],
    );
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
