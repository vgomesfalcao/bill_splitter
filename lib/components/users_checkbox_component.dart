import 'package:bill_splitter/controller/checkbox_controller.dart';
import 'package:flutter/material.dart';

/* List of users in checkbox list tile format
 Render a user list tile with checkbox
*/
class UsersCheckbox extends StatefulWidget {
  final String name;
  final CheckboxController checkboxController;
  const UsersCheckbox(
      {Key? key, required this.name, required this.checkboxController})
      : super(key: key);

  @override
  State<UsersCheckbox> createState() => _UsersCheckboxState();
}

class _UsersCheckboxState extends State<UsersCheckbox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      secondary: const Icon(Icons.people),
      title: Text(widget.name),
      checkColor: Colors.white,
      activeColor: Colors.blue,
      value: widget.checkboxController.getValue(),
      onChanged: (bool? value) {
        setState(() {
          widget.checkboxController.switchCheck();
        });
      },
    );
  }
}
