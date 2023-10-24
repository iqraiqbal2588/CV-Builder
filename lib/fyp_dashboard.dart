import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/DataEntryForms/PersonalDetails.dart';
import 'package:fyp/screens/DataEntryForms/nameAndContact.dart' as name;
import 'drawer.dart';
import 'job_dashboard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        centerTitle: true,
        title: const Text(
          'CV builder',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: 350,
                child: CarouselSlider(
                  items: [
                    Container(
                      height: 300,
                      width: 300,
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://www.jobhero.com/resources/wp-content/uploads/2022/07/resume-builder-hero-banner-new.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //2nd Image of Slider
                    Container(
                      height: 300,
                      width: 300,
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://flymycareer.com/wp-content/uploads/2021/10/istockphoto-1138075339-612x612-1-1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //3rd Image of Slider
                    Container(
                      height: 300,
                      width: 300,
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://cdn.dribbble.com/users/287476/screenshots/4966744/media/18eebdd7437d37f5887c8771a52ab5b3.png?resize=400x0"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //4th Image of Slider
                    Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://miro.medium.com/v2/resize:fit:1400/1*CrPl7dAspvYeCQJSzid5hg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 350.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.elasticOut,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 400),
                    viewportFraction: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 16.0,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  DashboardCard(
                    title: 'Create CV',
                    icon: Icons.book,
                    backgroundColor: const Color(0xFF536DFE),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const personal_info(),
                        ),
                      );
                    },
                  ),
                  DashboardCard(
                    title: 'Cover Letter',
                    icon: Icons.menu_book,
                    backgroundColor: const Color(0xFFBDBDBD),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const name.nameAndContact(),
                        ),
                      );
                    },
                  ),

                  DashboardCard(
                    title: 'Find Jobs',
                    icon: Icons.find_in_page,
                    backgroundColor: const Color(0xFFAB47BC),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp1(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
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

  const DashboardCard({
    super.key,
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
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 70,
              color: Colors.white,
            ),
            const SizedBox(height: 20.0),
            Text(
              title,
              style: const TextStyle(
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
