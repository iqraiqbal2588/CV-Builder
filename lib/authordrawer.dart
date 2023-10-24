import 'package:flutter/material.dart';

import 'loginclass.dart';

class authordrawer extends StatefulWidget {
  const authordrawer({Key? key}) : super(key: key);

  @override
  State<authordrawer> createState() => _authordrawerState();
}

class _authordrawerState extends State<authordrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 100,),
          ListTile(
            leading: Icon(
              Icons.delete,
              size: 34,
              color: Color(0xFF0D47A1),
            ),
            title: Text(
              'logout',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF0D47A1),
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyLogin()));
            },
          ),
        ],
      ),
    );
  }
}

