import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/fyp_dashboard.dart';

import 'jobsubmissionform.dart';

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom NavBar Demo',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        splashColor: Colors.blue,
        highlightColor: Colors.blueAccent,
        hoverColor: Colors.blue,
        backgroundColor: Colors.blue,
      ),

      home: HomePage(),

    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final pages = [
    ShowJobs(),
    about(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          },
        ),

      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: pageIndex == 0
                    ? const Icon(
                  Icons.work,
                  color: Colors.black,
                  size: 35,
                )
                    : const Icon(
                  Icons.work_outline,
                  color: Colors.black,
                  size: 35,
                ),
              ),
              Text(" Jobs",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
            ],
          ),

        ],
      ),
    );
  }
}
class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(20.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("About us ",style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Playfair Display"
              ),)
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 200,
                width: 200,
                color: Colors.grey,
                child: Image(image: NetworkImage("https://www.clearvision-cm.com/wp-content/uploads/2021/09/we-are-hiring.png"),),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 380,
                height: 410,
                color: Colors.white70,
                child: Text("CV Builder is an online platform that offers a range of tools and resources to help job seekers create compelling resumes and cover letters. Our mission is to simplify the job application process by providing users with a user-friendly interface and a variety of customizable templates that can be tailored to their specific needs."
                    " we understand that the job market is highly competitive and that a well-crafted resume can make all the difference. Our team of experts has developed a range of resources and tools to help job seekers create resumes that stand out from the crowd. We are committed to providing high-quality resources and excellent customer service to our users.",style:
                TextStyle(
                  fontSize: 20,
                    color: Colors.black,
                    fontFamily: "Playfair Display",
                  ),),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 260,
                // width: 310,
                color: Colors.grey,
                child: Image(image: NetworkImage("https://static.vecteezy.com/system/resources/previews/008/297/514/original/clean-professional-resume-and-cover-letter-layout-template-for-business-job-applications-minimalist-resume-cv-template-resume-design-cv-design-curriculum-vitae-design-template-free-vector.jpg"),),
              ),
              // Container(
              //   height: 200,
              //   width: 200,
              //   color: Colors.grey,
              //   child: Image(image: NetworkImage(""),),
              // ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 260,
                // width: 310,
                color: Colors.grey,
                child: Image(image: NetworkImage("https://elements-cover-images-0.imgix.net/4c7ff8be-8e2d-44ee-8fd6-ebaf6a698906?auto=compress%2Cformat&fit=max&w=900&s=f896c104cbff7e881e527116a46788d3"),),
              ),
              // Container(
              //   height: 200,
              //   width: 200,
              //   color: Colors.grey,
              //   child: Image(image: NetworkImage(""),),
              // ),
            ],
          ),
          SizedBox(height: 20,),

          Row(
            children: [
              SizedBox(width: 20,),
              Text("Contact us",style: TextStyle(
                fontSize: 30,
                fontFamily: "Playfair Display",
              ),),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [Padding(padding:EdgeInsets.all(10)),
              Container(
                height: 30,
                width: 30,
                child:Image(image: NetworkImage("https://img.freepik.com/free-icon/telephone-symbol-button_318-41893.jpg"),),

              ),
              SizedBox(width:40,),
              Text("+92-316-4136-893",style: TextStyle(
                fontSize: 20,
                fontFamily: "Playfair Display",
              ),)
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [Padding(padding:EdgeInsets.all(10)),
              Container(
                height: 30,
                width: 30,
                child:Image(image: NetworkImage("https://workspace.google.com/static/img/products/png/gmail.png?cache=f50ecb6"),),

              ),
              SizedBox(width:40,),
              Text("iqraiqbalcs@gmail.com",style: TextStyle(
                fontSize: 20,
                fontFamily: "Playfair Display",
              ),)
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [Padding(padding:EdgeInsets.all(10)),
              Container(
                height: 30,
                width: 30,
                child:Image(image: NetworkImage("https://www.facebook.com/images/fb_icon_325x325.png"),),

              ),
              SizedBox(width:40,),
              Text("iqraiqbal82",style: TextStyle(
                fontSize: 20,
                fontFamily: "Playfair Display",
              ),)
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [Padding(padding:EdgeInsets.all(10)),
              Container(
                height: 30,
                width: 30,
                child:Image(image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Instagram-Icon.png/1200px-Instagram-Icon.png"),),

              ),
              SizedBox(width:40,),
              Text("iqraiqbal82",style: TextStyle(
                fontSize: 20,
                fontFamily: "Playfair Display",
              ),)
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [Padding(padding:EdgeInsets.all(10)),
              Container(
                height: 30,
                width: 30,
                child: Image(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4n_urpJ9XpwOTdzBVbGvactwHrPagYQrTJPYjxfxLGkSyu7nJZVqRVGAeohnPgKMrnKE&usqp=CAU"),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                "iqraiqbal2588",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Playfair Display",
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class ShowJobs extends StatefulWidget {
  @override
  _ShowJobsState createState() => _ShowJobsState();
}

class _ShowJobsState extends State<ShowJobs> {
  late Future<QuerySnapshot<Map<String, dynamic>>> _jobFeaturesFuture;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _jobFeaturesFuture = getJobFeatures();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getJobFeatures() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('jobFeatures').get();

    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _jobFeaturesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No Job found.'),
            );
          }

          final jobDocs = snapshot.data!.docs;

          return ListView.separated(
            itemCount: jobDocs.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final jobData = jobDocs[index].data();

              final title = jobData['jobTitle'] as String? ?? 'No Title';
              final companyName =
                  jobData['companyName'] as String? ?? 'No Company Name';
              final place = jobData['place'] as String? ?? 'No place';
              final description =
                  jobData['description'] as String? ?? 'No place';
              final salary = jobData['salary'] as String? ?? 'No place';
              final gmail = jobData['gmail'] as String? ?? 'No place';
              final phone = jobData['phone'] as String? ?? 'No phone';

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 02,
                      ),
                      Text(
                        '${title}',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                          size: 35,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.home_work),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '${companyName}',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '${place}',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.work),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 30,
                        width: 150,
                        color: Colors.white60,
                        child: Text(
                          '${description}',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.add_card),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 30,
                        width: 300,
                        color: Colors.white70,
                        child: Text(
                          '${salary}',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.email),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '${gmail}',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.contacts_rounded),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '${phone}',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilePickerPage(
                                        uemail: gmail,
                                      )),
                            );
                          },
                          child: Text(
                            'Apply job',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

