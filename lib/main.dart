// import 'package:flutter/material.dart';
// import 'package:fyp/signup.dart';
//
// void main()
// {
//   runApp(const mainscreen());
// }
// class mainscreen extends StatelessWidget {
//   const mainscreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return loginclass();
//
//   }
// }
//
//
//
//
// //
// // class assest extends StatefulWidget {
// //   const assest({Key? key}) : super(key: key);
// //
// //   @override
// //   State<assest> createState() => secondscreen();
// // }
// //
// // class secondscreen extends State<assest> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: Scaffold(
// //         appBar: AppBar(
// //           centerTitle: true,
// //           backgroundColor: Colors.lightBlue,
// //           title: Text("Create Cv",
// //             style: TextStyle(
// //               fontSize: 30,
// //               fontFamily: "times new roman",
// //               fontWeight: FontWeight.bold,
// //
// //             ),),
// //           actions: [
// //             Icon(Icons.density_small_sharp),
// //           ],
// //         ),
// //         body: ListView(
// //           children: [
// //             SizedBox(height: 20,),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //               children: [
// //                 Container(
// //                   height: 200,
// //                   width: 200,
// //                   child: Image.asset('assets/images/tem-image-1.png'),
// //                 ),
// //                 Container(
// //                   height: 200,
// //                   width: 200,
// //                   child: Image.asset('assets/images/temp2-img.png'),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 15,),
// //
// //             Row(
// //               children: [
// //                 Container(
// //                   height: 200,
// //                   width: 200,
// //                   child: Image.asset('assets/images/tem-image-4.png'),
// //                 ),
// //                 Container(
// //                   height: 200,
// //                   width: 200,
// //                   child: Image.asset('assets/images/cv.png.png'),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 15,),
// //             Row(
// //               children: [
// //                 Container(
// //                   height: 200,
// //                   width: 200,
// //                   child: Image.asset('assets/images/cv.png-img.png'),
// //                 ),
// //                 Container(
// //                   height: 200,
// //                   width: 200,
// //                   child: Image.asset('assets/images/temp2.png'),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 15,),
// //             Row(
// //               children: [
// //                 Container(
// //                   height: 200,
// //                   width: 200,
// //                   child: Image.asset('assets/images/temp3-img.png'),
// //                 ),
// //                 Container(
// //                   height: 200,
// //                   width: 200,
// //                   child: Image.asset('assets/images/temp3.png'),
// //                 ),
// //               ],
// //             ),
// //             Container(
// //               child: ElevatedButton(onPressed: (){
// //                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyApp()));
// //               },child: Text("ANimation"),),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// //data entry forms
//
// // class MyApp extends StatefulWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //           appBar: AppBar(
// //             title: Text("Interest"),
// //             backgroundColor: Colors.transparent,
// //             actions: [
// //               IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
// //               SizedBox(width: 10,),
// //               TextButton(
// //                   onPressed: (){},
// //                   child: const Text("⊞ADD",
// //                     style: TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                         fontFamily: "Times New Roman",
// //                         color: Colors.purpleAccent
// //                     ),
// //                   )
// //               )
// //             ],
// //           ),
// //           body: Column(
// //             children: [
// //               SizedBox(height: 20,),
// //               ListTile(
// //                 title: Text("🏈 Football"),
// //                 // subtitle: Text("Subtitle"),
// //                 leading: Icon(Icons.edit),
// //                 trailing: Icon(Icons.delete),
// //               ),
// //               SizedBox(height: 700,),
// //               SizedBox(
// //                 width: 150,
// //                 child: ElevatedButton(
// //                   child: const Text('Next >'),
// //                   onPressed: (){},
// //                 ),
// //               )
// //             ],
// //           )
// //       ),
// //     );
// //   }
// // }
// // //education
//
// // class MyApp extends StatefulWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //           appBar: AppBar(
// //             title: Text("Education"),
// //             backgroundColor: Colors.transparent,
// //             actions: [
// //               IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
// //               SizedBox(width: 10,),
// //               TextButton(
// //                   onPressed: (){},
// //                   child: const Text("⊞ADD",
// //                     style: TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                         fontFamily: "Times New Roman",
// //                         color: Colors.purpleAccent
// //                     ),
// //                   )
// //               )
// //             ],
// //           ),
// //           body: Column(
// //             children: [
// //               SizedBox(height: 20,),
// //               ListTile(
// //                 title: Text("Title"),
// //                 subtitle: Text("Subtitle"),
// //                 leading: Icon(Icons.edit),
// //                 trailing: Icon(Icons.delete),
// //               ),
// //               SizedBox(height: 700,),
// //               SizedBox(
// //                 width: 150,
// //                 child: ElevatedButton(
// //                   child: const Text('Next >'),
// //                   onPressed: (){},
// //                 ),
// //               )
// //             ],
// //           )
// //       ),
// //     );
// //   }
// // }
//
//  //language
//
// // class MyApp extends StatefulWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //           appBar: AppBar(
// //             title: Text("Language"),
// //             backgroundColor: Colors.transparent,
// //             actions: [
// //               IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
// //               SizedBox(width: 10,),
// //               TextButton(
// //                   onPressed: (){},
// //                   child: const Text("⊞ADD",
// //                     style: TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                         fontFamily: "Times New Roman",
// //                         color: Colors.purpleAccent
// //                     ),
// //                   )
// //               )
// //             ],
// //           ),
// //           body: Column(
// //             children: [
// //               SizedBox(height: 20,),
// //               ListTile(
// //                 title: Text("Title"),
// //                 subtitle: Text("⭐⭐⭐⭐⭐"),
// //                 leading: Icon(Icons.edit),
// //                 trailing: Icon(Icons.delete),
// //               ),
// //               SizedBox(height: 700,),
// //               SizedBox(
// //                 width: 150,
// //                 child: ElevatedButton(
// //                   child: const Text('Next >'),
// //                   onPressed: (){},
// //                 ),
// //               )
// //             ],
// //           )
// //       ),
// //     );
// //   }
// // }
//
// //socail
//
// // class MyApp extends StatefulWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //           appBar: AppBar(
// //             title: Text("Social"),
// //             backgroundColor: Colors.transparent,
// //             actions: [
// //               IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
// //               SizedBox(width: 10,),
// //               TextButton(
// //                   onPressed: (){},
// //                   child: const Text("⊞ADD",
// //                     style: TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                         fontFamily: "Times New Roman",
// //                         color: Colors.purpleAccent
// //                     ),
// //                   )
// //               ),
// //             ],
// //           ),
// //           body: Column(
// //             children: [
// //               SizedBox(height: 20,),
// //               ListTile(
// //                 title: Text("Facebook"),
// //                 // subtitle: Text("Subtitle"),
// //                 leading: Icon(Icons.edit),
// //                 trailing: Icon(Icons.delete),
// //               ),
// //               ListTile(
// //                 title: Text("Twitter"),
// //                 // subtitle: Text("Subtitle"),
// //                 leading: Icon(Icons.edit),
// //                 trailing: Icon(Icons.delete),
// //               ),
// //               ListTile(
// //                 title: Text("Instagram"),
// //                 // subtitle: Text("Subtitle"),
// //                 leading: Icon(Icons.edit),
// //                 trailing: Icon(Icons.delete),
// //               ),
// //               SizedBox(height: 600,),
// //               SizedBox(
// //                 width: 150,
// //                 child: ElevatedButton(
// //                   child: const Text('Next >'),
// //                   onPressed: (){},
// //                 ),
// //               )
// //             ],
// //           )
// //       ),
// //     );
// //   }
// // }
//
// //experience
// // class MyApp extends StatefulWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //           appBar: AppBar(
// //             title: Text("Experience"),
// //             backgroundColor: Colors.transparent,
// //             actions: [
// //               IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
// //               SizedBox(width: 10,),
// //               TextButton(
// //                   onPressed: (){},
// //                   child: const Text("⊞ADD",
// //                     style: TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                         fontFamily: "Times New Roman",
// //                         color: Colors.purpleAccent
// //                     ),
// //                   )
// //               )
// //             ],
// //           ),
// //           body: Column(
// //             children: [
// //               SizedBox(height: 20,),
// //               ListTile(
// //                 title: Text("Title"),
// //                 subtitle: Text("Subtitle"),
// //                 leading: Icon(Icons.edit),
// //                 trailing: Icon(Icons.delete),
// //               ),
// //               SizedBox(height: 700,),
// //               SizedBox(
// //                 width: 150,
// //                 child: ElevatedButton(
// //                   child: const Text('Next >'),
// //                   onPressed: (){},
// //                 ),
// //               )
// //             ],
// //           )
// //       ),
// //     );
// //   }
// // }
//
//
// //objective
//
// // class MyApp extends StatefulWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //           appBar: AppBar(
// //             title: const Text("Objective"),
// //             backgroundColor: Colors.transparent,
// //             actions: [
// //               IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
// //               const SizedBox(width: 10,),
// //               // TextButton(
// //               //     onPressed: (){},
// //               //     child: const Text("⊞ADD",
// //               //     style: TextStyle(
// //               //       fontSize: 20,
// //               //       fontWeight: FontWeight.bold,
// //               //       fontFamily: "Times New Roman",
// //               //       color: Colors.purpleAccent
// //               //       ),
// //               //     )
// //               // )
// //             ],
// //           ),
// //           body: Padding(
// //             padding: const EdgeInsets.all(10.0),
// //             child: ListView(
// //               children: [
// //                 Column(
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   children: [
// //                     const SizedBox(height: 20,),
// //                     const TextField(
// //                       decoration: InputDecoration(
// //                         contentPadding: EdgeInsets.symmetric(vertical: 80.0),
// //                         border: OutlineInputBorder(),
// //                         helperMaxLines: 5,
// //                         labelText: "Title",
// //                       ),
// //                     ),
// //                     const SizedBox(height: 20,),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.start,
// //                       children: [
// //                         const Text("Examples:"),
// //                       ],
// //                     ),
// //                     SizedBox(height: 500,),
// //                     SizedBox(
// //                       width: 150,
// //                       child: ElevatedButton(
// //                         child: const Text('Next >'),
// //                         onPressed: (){},
// //                       ),
// //                     )
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           )
// //       ),
// //     );
// //   }
// // }
// //
// //
// // //skills
// //
// // class MyApp extends StatefulWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //           appBar: AppBar(
// //             title: Text("Skill"),
// //             backgroundColor: Colors.transparent,
// //             actions: [
// //               IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
// //               SizedBox(width: 10,),
// //               TextButton(
// //                   onPressed: (){},
// //                   child: const Text("⊞ADD",
// //                     style: TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                         fontFamily: "Times New Roman",
// //                         color: Colors.purpleAccent
// //                     ),
// //                   )
// //               )
// //             ],
// //           ),
// //           body: Column(
// //             children: [
// //               SizedBox(height: 20,),
// //               ListTile(
// //                 title: Text("Title"),
// //                 subtitle: Text("⭐⭐⭐⭐⭐"),
// //                 leading: Icon(Icons.edit),
// //                 trailing: Icon(Icons.delete),
// //               ),
// //               SizedBox(height: 700,),
// //               SizedBox(
// //                 width: 150,
// //                 child: ElevatedButton(
// //                   child: const Text('Next >'),
// //                   onPressed: (){},
// //                 ),
// //               )
// //             ],
// //           )
// //       ),
// //     );
// //   }
// // }
//
// //job dashboard
//
//
