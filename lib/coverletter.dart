import 'package:flutter/material.dart';
import 'package:fyp/output/coverletter1.dart';
import 'package:fyp/output/coverletter2.dart';
import 'package:fyp/output/coverletter3.dart' as three;
import 'package:fyp/output/coverletter4.dart' as four;

class coverletter extends StatefulWidget {
  const coverletter({Key? key}) : super(key: key);

  @override
  State<coverletter> createState() => _coverletterState();
}

class _coverletterState extends State<coverletter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF0D47A1),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios,size: 30,),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Cover-letter',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0)),
                SizedBox(width: 10.0),
                Text('Templates',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize:30.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(75.0),
                topRight: Radius.circular(75.0),
              ),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 45.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 300,
                    child: ListView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CLScreen()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/WhatsApp Image 2023-05-09 at 6.55.43 PM.jpeg',
                                      width: 180,
                                      height: 200,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CoverLetter()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/WhatsApp Image 2023-05-09 at 6.56.03 PM.jpeg',
                                      width: 180,
                                      height: 200,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => three.CLScreen()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/WhatsApp Image 2023-05-09 at 6.53.28 PM.jpeg',
                                      width: 180,
                                      height: 200,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => four.CoverLetter()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/WhatsApp Image 2023-05-09 at 6.56.03 PM.jpeg',
                                      width: 180,
                                      height: 200,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildFoodItem(String imgPath, String foodName, ) {
  return Padding(
      padding: EdgeInsets.only(left: 1.0, right: 10.0, bottom: 20.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: Row(
                  children: [
                    Hero(
                        tag: imgPath,
                        child: Image(
                            image: AssetImage(imgPath),
                            fit: BoxFit.cover,
                            height:120.0,
                            width:100.0
                        )
                    ),
                    SizedBox(width: 20.0),

                    Text(
                        foodName,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 21.0,
                            fontWeight: FontWeight.w400,
                        )
                    ),


                  ]
              )
          ),
          IconButton(
              icon: Icon(Icons.edit,size: 35,),
              color: Color(0xFF0D47A1),

              onPressed: () {}
          )
        ],
      )
  );
}
