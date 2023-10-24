// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
// import 'package:dynamic_link/firebase_dynamic_link.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import 'admindrawer.dart';

Future initDynamicLink() async {
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  if (initialLink != null) {
    final Uri deepLink = initialLink.link;

    Get.toNamed(deepLink.path.toString());
  } else {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      Get.toNamed(dynamicLinkData.link.path.toString());
    }).onError((error) {
      // Handle errors
      print('error');
    });
  }
}

Future createLink(String ur) async {
  DynamicLinkParameters parameters = DynamicLinkParameters(
      androidParameters: AndroidParameters(packageName: 'com.example.fyp'),
      link: Uri.parse('https://jobfeatures.page.link/' + ur),
      uriPrefix: 'https://jobfeatures.page.link');
  ShortDynamicLink link =
      await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  Share.share(link.shortUrl.toString());
}

class dynamiclink extends StatefulWidget {
  const dynamiclink({Key? key}) : super(key: key);

  @override
  State<dynamiclink> createState() => _dynamiclinkState();
}

class _dynamiclinkState extends State<dynamiclink> {
  @override
  void initState() {
    initDynamicLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {'/CustomDrawer': (context) => CustomDrawer()},
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            //toolbarHeight: 70,

            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomDrawer()));
              },
            ),
            actions: [
              IconButton(
                iconSize: 35,
                icon: const Icon(Icons.share_sharp),
                onPressed: () {
                  createLink('CustomDrawer');
                },
              ),
            ],
            centerTitle: true,
            title: Text("Dynamic Link "),
          ),
          backgroundColor: Colors.transparent,
        ),
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       fit: BoxFit.contain,
        //       image: NetworkImage("https://images.all-free-download.com/images/graphiclarge/online_shopping_concept_woman_shopping_in_laptop_design_6826033.jpg"),
        //
        //     ),
        // ),
      ),
    );
  }
}
