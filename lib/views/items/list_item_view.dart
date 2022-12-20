// ignore_for_file: use_key_in_widget_constructors

import 'package:bill_splitter/model/bill/bill_model.dart';
import 'package:bill_splitter/model/bill/item_model.dart';
import 'package:bill_splitter/model/user/user_list_model.dart';
import 'package:bill_splitter/utils/formatter.dart';
import 'package:bill_splitter/views/items/form_item_view.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final String _itemListTitle = 'Itens';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_itemListTitle),
      ),
      body: ListView.builder(
          itemCount: Bill().getBillList().length,
          itemBuilder: (context, index) {
            return ItemRow(item: Bill().getBillList()[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (UserListModel().getUsers().length >= 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ItemRegisterForm();
            })).then((receivedItem) => _update(receivedItem));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Necessário pelo menos duas pessoas cadastradas'),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _update(BillItem receivedItem) {
    setState(() {
      Bill().addBillItem(receivedItem);
    });
  }
}

class ItemRow extends StatelessWidget {
  final BillItem _item;

  const ItemRow({item}) : _item = item;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on_outlined),
      title: Text(_item.itemLabel),
      subtitle: Text(Formatter().formatCurrencyNumber(number: _item.itemValue)),
    ));
  }
}
