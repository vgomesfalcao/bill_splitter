import 'package:bill_splitter/components/bill_list_tile_component.dart';
import 'package:bill_splitter/components/user_bill_tile_component.dart';
import 'package:bill_splitter/controller/form_item_controller.dart';
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
        title: Transform.translate(
            offset: const Offset(0, 8), child: const Text('Conta')),
        centerTitle: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(150),
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
          child: SizedBox(height: 45, child: tipButton())),
      body: UserBillTile(formItemController: _formItemController),
    );
  }

  ListTile tipButton() {
    return ListTile(
        title: Center(
      child: Transform.translate(
        offset: const Offset(0, -4),
        child: SizedBox.expand(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              const Text(
                'Taxa Serviço',
                style: TextStyle(fontSize: 17),
              ),
              Switch(
                  value: _formItemController.getTip(),
                  onChanged: (bool value) {
                    setState(() => _formItemController.changeTip());
                  }),
            ])),
      ),
    ));
  }
}
