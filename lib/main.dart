import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medico/Pages/appointment_form.dart';
import 'package:medico/Pages/doctor_review_list.dart';
import 'package:medico/Pages/medicine_review_list.dart';
import 'package:medico/Pages/opinion_request_list.dart';
import 'package:medico/Pages/prescription_request_list.dart';
import 'package:medico/Reminders.dart';
import 'package:medico/UI/fancy_tab_bar.dart';
import 'package:medico/utils/auth.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:medico/utils/first_aid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyApp extends StatelessWidget {
  String _userId;
  BaseAuth _auth;
  VoidCallback _onSignedOut;

  MyApp(this._userId, this._auth, this._onSignedOut) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness:
          Brightness.light, //or set color with: Color(0xFF0000FF)
    ));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Montserrat'),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;

  FancyTabBar tabBar;
  void pageChanged(int pos) {
    _pageController.animateToPage(pos,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 1, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    tabBar = FancyTabBar(pageChanged);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
            PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                tabBar.changePage(index);
              },
              children: <Widget>[
                OpinionRequestList(
                  title: 'some',
                  subtitle: 'sme',
                ),
                CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                            height: 200,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return AppointmentForm();
                                }));
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Appointment Request',
                                          style: TextStyle(fontSize: 28),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.add,
                                          size: 60.0,
                                        )
                                      ],
                                    ),
                                  )),
                            )),
                        Container(
                            height: 200,
                            width: double.infinity,
                            child: InkWell(
                              onTap: _launchURL,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Chat Bot',
                                        style: TextStyle(fontSize: 28),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.account_circle,
                                        size: 60.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            height: 250,
                            width: double.infinity,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12.0)),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) {
                                                  return MedicineReviewList();
                                                }));
                                              },
                                              child: Image(
                                                fit: BoxFit.fill,
                                                image: CachedNetworkImageProvider(
                                                    'https://images.theconversation.com/files/101120/original/image-20151106-16242-12xhw43.jpg'),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            'Medicine Review',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          )
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight:
                                                    Radius.circular(12.0)),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) {
                                                  return DoctorReviewList();
                                                }));
                                              },
                                              child: Image(
                                                fit: BoxFit.fill,
                                                image: CachedNetworkImageProvider(
                                                    'http://topendtraveldoctor.com.au/wp-content/uploads/2016/12/anonymous-female.png'),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            'Doctor Reviews',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Container(
                            height: 200,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return PrescriptionRequestList();
                                }));
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'My Prescription',
                                          style: TextStyle(fontSize: 28),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.list,
                                          size: 60.0,
                                        )
                                      ],
                                    ),
                                  )),
                            )),
                        Container(
                            height: 200,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return Reminders();
                                }));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Reminders',
                                        style: TextStyle(fontSize: 28),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.notifications_active,
                                        size: 60.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            height: 200,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                _pickSaveImage('files');
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Upload Prescription',
                                        style: TextStyle(fontSize: 28),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.cloud_upload,
                                        size: 60.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 70,
                        )
                      ]),
                    )
                  ],
                ),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return FirstAid(index);
                            }));
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Hero(
                                          tag: '${index}',
                                          child: Image(
                                            fit: BoxFit.fill,
                                            image: CachedNetworkImageProvider(
                                                index == 0
                                                    ? 'https://d3utvp06f2exxv.cloudfront.net/article/dengue-fever-do-not-panic-1518.jpg'
                                                    : index == 1
                                                    ? 'https://ayushology.com/wp-content/uploads/2017/12/how-to-cure-jaundice-at-home-naturally.jpg'
                                                    : 'http://dahabclinic.com/wp-content/uploads/2017/12/article-enteric-fever.jpg'),
                                          ))),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        index==0?'Jaundice':index==1?'Dengue':'Typhoid',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: tabBar,
            )
          ],
        ));
  }

  Future<String> _pickSaveImage(String imageId) async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    var rng = new Random();
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child(imageId)
        .child("image${rng.nextInt(100000000)}.jpg");
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    return await (await uploadTask.onComplete).ref.getDownloadURL().then((val) async {
      print(val);
      await FirebaseDatabase.instance
          .reference()
          .child('unverified').push()
          .set({'imgURL': val.toString(), 'patientID': '9620908970'});
    });
  }

  _launchURL() async {
    const url = 'https://telegram.me/ngaka_bot';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
