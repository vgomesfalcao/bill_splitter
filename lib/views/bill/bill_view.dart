import 'package:bill_splitter/controller/form_item_controller.dart';
import 'package:bill_splitter/model/user/user_list_model.dart';
import 'package:flutter/material.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final FormItemController _formItemController = FormItemController();
  bool withTip = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Total')),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: ListTile(
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  const Text(
                    '10%',
                    style: TextStyle(fontSize: 17),
                  ),
                  Switch(
                      value: _formItemController.getTip(),
                      onChanged: (bool value) {
                        setState(() => _formItemController.changeTip());
                      }),
                ],
              ),
            ),
            leading: const Icon(Icons.monetization_on),
            title: Text.rich(
                TextSpan(style: const TextStyle(fontSize: 20), children: [
              const TextSpan(text: 'Total: '),
              TextSpan(
                  text: _formItemController.getTotalBillWithTip(),
                  style: const TextStyle(fontWeight: FontWeight.bold))
            ])),
          ),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: UserListModel().getUsers().length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: const Center(
                    widthFactor: 0.6,
                    child: Icon(Icons.monetization_on_outlined, size: 60)),
                title: Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 6.0),
                  child: Text(
                    UserListModel().getUsers()[index].name,
                  ),
                ),
                subtitle: _formItemController.getValueFromUserIndex(index),
                isThreeLine: true,
              ),
            );
          }),
    );
  }
}
