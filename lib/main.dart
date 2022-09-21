import 'package:bill_splitter/views/bill/bill_view.dart';
import 'package:bill_splitter/views/items/list_item_view.dart';
import 'package:bill_splitter/views/user/list_user_view.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(const BillSplitter());
}

class BillSplitter extends StatelessWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavigationBar(),
    );
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const UserList(),
    const ItemList(),
    const BillScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pessoas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Itens',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Conta',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
