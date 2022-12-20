import 'package:flutter/material.dart';

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
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
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
