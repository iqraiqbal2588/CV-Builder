import 'package:flutter/material.dart';

import 'admincomapnyregister.dart';
import 'admindrawer.dart';
import 'adminmanagejob.dart';
import 'feedbacklist.dart';
import 'manageauthor.dart';
import 'manageuser.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AdminDashboardScreen(),
  ));
}

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        centerTitle: true,

          title: Text('Dashboard'),
      ),

        body: ListView(

          children: <Widget>[
            SizedBox(height: 100.0),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              shrinkWrap: true,
              children: <Widget>[
                DashboardCard(
                  title: ' Manage Users',
                icon: Icons.people,
                backgroundColor: Color(0xFF0D47A1),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPanelScreen(),
                    ),
                  );
                },
              ),
                // 50: Color(0xFFEFEBE9),
                // 100: Color(0xFFD7CCC8),
                // 200: Color(0xFFBCAAA4),
                // 300: Color(0xFFA1887F),
                // 400: Color(0xFF8D6E63),
                // 500: Color(_brownPrimaryValue),
                // 600: Color(0xFF6D4C41),
                // 700: Color(0xFF5D4037),
                // 800: Color(0xFF4E342E),
                // 900: Color(0xFF3E2723),
                DashboardCard(
                  title: ' Manage Jobs',
                icon: Icons.edit,
                backgroundColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => adminmanagejob(),
                    ),
                  );
                },
              ),
                DashboardCard(
                  title: 'Manage Author',
                icon: Icons.person,
                backgroundColor: Colors.cyan,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => manageAuthor(),
                    ),
                  );
                },
              ),

              DashboardCard(
                title: '     Registered '
                    '            Company',
                icon: Icons.settings,
                backgroundColor: Colors.red,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => registeredCompany(),
                    ),
                  );
                },
              ),
              DashboardCard(
                title: 'User Feedbacks',
                icon: Icons.feedback,
                backgroundColor: Colors.cyan,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackListPage(),
                    ),
                  );
                },
              ),
            ],
            ),
            SizedBox(height: 20,),
        ],
        ),

    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  DashboardCard({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 70,
              color: Colors.white,
            ),
            SizedBox(height: 20.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
