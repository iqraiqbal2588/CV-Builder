import 'package:flutter/material.dart';
import 'package:fyp/output/cv1.dart';
import 'package:fyp/output/cv4.dart';

import 'output/cv2.dart';
import 'output/cv3.dart';

class createcv extends StatefulWidget {
  const createcv({Key? key}) : super(key: key);

  @override
  State<createcv> createState() => _createcvState();
}

class _createcvState extends State<createcv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D47A1),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  }
                  ,
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('CV',
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
                        fontSize: 30.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0),topRight: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child:Container(
                        height: MediaQuery.of(context).size.height - 300.0,
                        child: ListView(children: [
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
                                            builder: (context) => searchjobs()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/temp1.png',
                                      width: 180,
                                      height: 200,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CV1()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/temp2.png',
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
                                            builder: (context) => CV3()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/grey3.png',
                                      width: 180,
                                      height: 200,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CV4()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/grey5.png',
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
                                            builder: (context) => CV1()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/temp2.png',
                                      width: 180,
                                      height: 200,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => searchjobs()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/temp1.png',
                                      width: 180,
                                      height: 200,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // _buildFoodItem(
                          //   'assets/images/temp1.png',
                          //   'Crisp Blue',
                          // ),
                          // _buildFoodItem(
                          //   'assets/images/temp2.png',
                          //   'Cubic Blue',
                          // ),
                          // //grey
                          // _buildFoodItem(
                          //   'assets/images/grey2.png',
                          //   'Crisp Grey',
                          // ),
                          // _buildFoodItem(
                          //   'assets/images/grey4.png',
                          //   'Cubic Grey',
                          // ),
                          // //brown
                          // _buildFoodItem(
                          //   'assets/images/brown1.png',
                          //   'Crisp brown-simple',
                          // ),
                          // _buildFoodItem(
                          //   'assets/images/brown3.png',
                          //   'Cubic brown',
                          // ),
                          //
                          // //green
                          // _buildFoodItem('assets/images/green1.png', 'Crisp green', ),
                          // _buildFoodItem('assets/images/green3.png', 'Cubic green', ),
                          // //
                          //
                          // _buildFoodItem('assets/images/orange1.png', 'crisp orange', ),
                          // _buildFoodItem('assets/images/orange3.png', 'Cubic orange', ),
                        ]
                        )
                    )
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
                        SizedBox(width: 10.0),

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
              icon: Icon(
                Icons.edit,
                size: 35,
              ),
              color: Color(0xFF0D47A1),
              onPressed: () {})
        ],
          )
      );
}
