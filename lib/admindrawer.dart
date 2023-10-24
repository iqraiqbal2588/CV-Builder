import 'package:flutter/material.dart';

import 'loginclass.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyLogin()));
            },
          ),
        ],
      ),
    );
  }
}
