import 'package:flutter/material.dart';

import 'drawer.dart';
class help extends StatefulWidget {
  const help({Key? key}) : super(key: key);

  @override
  State<help> createState() => _helpState();
}

class _helpState extends State<help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => CustomDrawer()));
          },
        ),
        title: Text("How to make CV",style: TextStyle(
          fontSize: 22,
          color: Colors.black,
        ),),
      actions: [
        Icon(Icons.tips_and_updates_outlined,color: Colors.black,
        size: 28,),
      ],
      ),

      body: ListView(
        children: [
          SizedBox(height: 10,),

          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text("How To Make CV",style: TextStyle(
                fontSize: 30,
                color: Colors.black,

              ),),

            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Image.network(
              'https://img.freepik.com/free-photo/young-smiley-businesswomen-working-with-laptop-desk_23-2148824883.jpg?w=2000',
              width: 100,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(
                width: 30,

              ),
              Container(
                height: 80,
                width: 360,
                color: Colors.white60,
                child: Text("You can quickly and easily make CV , Cover Letter "
                    "to following few step which are given below",style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,

                ),),

              ),

            ],
          ),
            SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Container(
                height: 150,
                width: 360,
                color: Colors.white60,
                child: Text("1.Choose a CV template: Most CV builder apps provide pre-designed templates for you to choose from. You can select a template that matches your style and preferences."

    ,style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,

                ),),

              ),
              ]),
              Column(
                children: [
                  Container(
                    height: 150,
                    width: 360,
                    color: Colors.white60,
                    child: Text(

                      "2.Enter your personal information: This typically includes your name, contact information, and other relevant details like your address, email address, and phone number."

                      ,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,

                    ),),

                  ),
                ],
              ),


              Column(
                children: [
                  Container(
                    height: 120,
                    width: 360,
                    color: Colors.white60,
                    child: Text(

                        "3.Add your work experience: Enter your work history, including your previous job titles, company names, employment dates, and job duties."

                        ,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,

                    ),),

                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 120,
                    width: 360,
                    color: Colors.white60,
                    child: Text(

                        "4.Enter your education: This typically includes your degrees, certifications, and any relevant coursework or training you've completed."

                        ,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,

                    ),),

                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 120,
                    width: 360,
                    color: Colors.white60,
                    child: Text(

                        "5.Add your skills: List any relevant skills you have, such as computer skills, language proficiency, or other specialized skills."

                        ,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,

                    ),),

                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height:150,
                    width: 360,
                    color: Colors.white60,
                    child: Text(

                        "6.Customize your CV: Depending on the app you're using, you may be able to customize your CV by changing fonts, colors, or other design elements."

                        ,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,

                    ),),

                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 200,
                    width: 360,
                    color: Colors.white60,
                    child: Text(


                          "7.Preview and save your CV: Once you've completed your CV, preview it to make sure everything looks correct. Then, save your CV in a format that you can easily share with potential employers, such as a PDF or Word document."

                          ,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,

                    ),),

                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 200,
                    width: 360,
                    color: Colors.white60,
                    child: Text(


                          "8.Update and refine your CV: As you gain more experience and skills, update your CV to reflect these changes. You may also want to refine your CV over time to better target specific job opportunities.",style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,

                    ),),

                  ),
                ],
              ),
          SizedBox(height: 10,),


]
    ),
    );
  }
}
