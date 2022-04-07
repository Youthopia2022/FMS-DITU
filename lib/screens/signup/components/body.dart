import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String _username;
  late int _college = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
          child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: TextFormField(
              keyboardType: TextInputType.name,
              key: const ValueKey('username'),
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                labelText: "username",
              ),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return "Incorrect name";
                }
                return null;
              },
              onSaved: (value) {
                _username = value!;
              },
            ),
          ),
          GroupButton(
              buttons: const ["Male", "Female", "Other"],
              onSelected: (i, selected) =>
                  debugPrint("$i is selected $selected")),
          GroupButton(
              buttons: const ["DIT", "Other"],
              onSelected: (i, selected) {
                setState(() {
                  _college = i;
                });
              }),
          _college == 0
              ? SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    key: const ValueKey('email'),
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                      labelText: "1000020104@dit.edu.in",
                    ),
                    onSaved: (value) {},
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    key: const ValueKey('email'),
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                      labelText: "john@gmail.com",
                    ),
                    onSaved: (value) {},
                  ),
                ),
          GroupButton(
            buttons: const ["1st year", "2nd year", "3rd year", "4th year"],
            onSelected: (i, selected) => debugPrint("$i is selected $selected"),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: TextFormField(
              keyboardType: TextInputType.name,
              key: const ValueKey('password'),
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                labelText: "password",
              ),
              validator: (value) {},
              onSaved: (value) {},
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: TextFormField(
              keyboardType: TextInputType.name,
              key: const ValueKey('re-enterPassword'),
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                labelText: "re-enter password",
              ),
              validator: (value) {},
              onSaved: (value) {},
            ),
          ),
          TextButton(onPressed: (){}, child: const Text("Submit")),
        ],
      )),
    );
  }
}
