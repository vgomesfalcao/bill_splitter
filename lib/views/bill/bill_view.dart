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
  static const double _fontSize = 16;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta'),
        centerTitle: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(160),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                BillListTile(
                  icon: Icons.shopping_cart,
                  label: 'Consumo',
                  fontSize: _fontSize,
                  value: _formItemController.getTotalBillWithoutTip(),
                ),
                BillListTile(
                  icon: Icons.room_service,
                  label: 'Serviço',
                  fontSize: _fontSize,
                  value: _formItemController.getTipValue(),
                ),
                const BillListTile(
                  icon: Icons.music_note,
                  label: 'Couvert',
                  fontSize: _fontSize,
                  value: 'R\$ 0,00',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text.rich(TextSpan(
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      children: [
                        const TextSpan(
                            text: 'Total   ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: _formItemController.getTotalBillWithTip(),
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
              height: 60,
              child: ListTile(
                  title: Center(
                child: SizedBox(
                    width: 100,
                    child: Row(children: [
                      const Text(
                        '10%',
                        style: TextStyle(fontSize: 17),
                      ),
                      Switch(
                          value: _formItemController.getTip(),
                          onChanged: (bool value) {
                            setState(() => _formItemController.changeTip());
                          }),
                    ])),
              )))),
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

class BillListTile extends StatefulWidget {
  const BillListTile(
      {super.key,
      required double fontSize,
      required String label,
      required String value,
      required IconData icon})
      : _fontSize = fontSize,
        _label = label,
        _value = value,
        _icon = icon;

  final double _fontSize;
  final String _label;
  final String _value;
  final IconData _icon;

  @override
  State<BillListTile> createState() => _BillListTileState();
}

class _BillListTileState extends State<BillListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
      dense: true,
      leading: Icon(
        widget._icon,
        color: Colors.white,
      ),
      title: Text.rich(TextSpan(
          style: TextStyle(fontSize: widget._fontSize, color: Colors.white),
          children: [TextSpan(text: widget._label)])),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            Transform.translate(
              offset: const Offset(10, 0),
              child: Text.rich(TextSpan(
                  style: TextStyle(
                      fontSize: widget._fontSize, color: Colors.white),
                  children: [
                    TextSpan(
                        text: widget._value,
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
