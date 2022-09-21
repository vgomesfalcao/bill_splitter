import 'package:bill_splitter/model/user/user_model.dart';
import 'package:bill_splitter/model/user/user_list_model.dart';
import 'package:bill_splitter/views/user/form_user_view.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> {
  final String _appbarUsersTitle = 'Pessoas';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appbarUsersTitle),
      ),
      body: ListView.builder(
          itemCount: UserListModel().getUsers().length,
          itemBuilder: (context, index) {
            return UserItem(UserListModel().getUsers()[index]);
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const UserRegisterForm();
          })).then((receivedUser) => _update(receivedUser));
        },
      ),
    );
  }

  void _update(User receivedUser) {
    setState(() {
      UserListModel().addUser(receivedUser);
    });
  }
}

class UserItem extends StatelessWidget {
  final User _user;

  const UserItem(this._user);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.people),
      title: Text(_user.name),
    ));
  }
}
