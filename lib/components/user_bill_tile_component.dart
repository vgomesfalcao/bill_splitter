import 'package:bill_splitter/controller/form_item_controller.dart';
import 'package:bill_splitter/model/user/user_list_model.dart';
import 'package:flutter/material.dart';

class UserBillTile extends StatefulWidget {
  const UserBillTile({
    super.key,
    required FormItemController formItemController,
  }) : _formItemController = formItemController;

  final FormItemController _formItemController;

  @override
  State<UserBillTile> createState() => _UserBillTileState();
}

class _UserBillTileState extends State<UserBillTile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: UserListModel().getUsers().length,
        itemBuilder: (context, index) {
          return Card(
            child: ExpansionTile(
              leading: const Icon(Icons.person),
              title: Transform.translate(
                offset: const Offset(-20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      UserListModel().getUsers()[index].name,
                    ),
                    Text(
                      widget._formItemController
                          .getUserBillWithTipToString(index),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: ListTile(
                    title:
                        widget._formItemController.getValueFromUserIndex(index),
                  ),
                )
              ],
            ),
          );
        });
  }
}
