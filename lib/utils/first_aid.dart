import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstAid extends StatefulWidget {
  int index;

  FirstAid(this.index);

  @override
  _FirstAidState createState() => _FirstAidState();
}

class _FirstAidState extends State<FirstAid> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<String> symp1 = [
    'fatigue',
    'abdominal pain',
    'weight loss',
    'vomiting',
    'fever',
    'pale stools',
    'dark urine'
  ],
      symp2 = [
    'Pain areas: in the abdomen, back, back of the eyes, bones, joints, or muscles',
    'Whole body: chills, fatigue, fever, or loss of appetite',
    'Gastrointestinal: nausea or vomiting',
    'Skin: rashes or red spots',
    'Also common: easy bruising or headache'
  ],
      symp3 = [
    'Pain areas: in the abdomen or muscles',
    'Gastrointestinal: bloating, constipation, diarrhoea, nausea, or vomiting',
    'Whole body: fatigue, fever, chills, loss of appetite, or malaise',
    'Also common: headache, muscle weakness, rash with small red dots, skin rash, or weight loss'
  ],
      symptoms = [];

  List<String> prec1 = [
    'Drink Clean Water',
    'Avoid Spicy Foods',
    'Visit doctor if any symptoms match'
  ],
      prec2 = [
    'Avoid Mosquitoes',
    'Keep Environment Clean',
    'Visit doctor if any symptoms match'
  ],
      prec3 = [
    'avoid raw fruits',
    'avoid drinking untreaed water',
    'choose hot food',
    'Visit doctor if any symptoms match'
  ],
      precautions = [];

  @override
  Widget build(BuildContext context) {
    symptoms = widget.index == 0 ? symp1 : widget.index == 1 ? symp2 : symp3;
    precautions = widget.index == 0 ? prec1 : widget.index == 1 ? prec2 : prec3;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Montserrat"),
      home: Scaffold(
        body: Container(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: true,
                backgroundColor: Colors.purple,
                expandedHeight: MediaQuery.of(context).size.height / 2.5,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(widget.index == 0
                      ? 'Jaundice'
                      : widget.index == 1 ? 'Dengue' : 'Typhoid'),
                  background: Hero(
                      tag: '${widget.index}',
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.index == 0
                            ? 'https://d3utvp06f2exxv.cloudfront.net/article/dengue-fever-do-not-panic-1518.jpg'
                            : widget.index == 1
                                ? 'https://ayushology.com/wp-content/uploads/2017/12/how-to-cure-jaundice-at-home-naturally.jpg'
                                : 'http://dahabclinic.com/wp-content/uploads/2017/12/article-enteric-fever.jpg',
                        placeholder: CircularProgressIndicator(),
                        errorWidget: Icon(Icons.error),
                      )),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 4.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 18.0,
                        ),
                        Text(
                          'Symptoms',
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Column(
                          children: getSymptoms(),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 4.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 18.0,
                        ),
                        Text(
                          'Precautions',
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Column(
                          children: getPrecautions(),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getSymptoms() {
    int index = 1;
    List<Widget> symps = [];
    while (index <= symptoms.length) {
      symps.add(Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListTile(
          dense: true,
          leading: CircleAvatar(
            radius: 11.0,
            backgroundColor: Colors.red,
            child: Text(
              '${index}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          title: Text(symptoms[index - 1],
              style: TextStyle(fontSize: 18, fontFamily: "Montserrat")),
        ),
      ));
      index++;
    }
    return symps;
  }

  List<Widget> getPrecautions() {
    int index = 1;
    List<Widget> precauts = [];
    while (index <= precautions.length) {
      precauts.add(Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListTile(
          dense: true,
          leading: CircleAvatar(
            radius: 11.0,
            backgroundColor: Colors.green,
            child: Text(
              '${index}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          title: Text(precautions[index - 1],
              style: TextStyle(fontSize: 18, fontFamily: "Montserrat")),
        ),
      ));
      index++;
    }
    return precauts;
  }
}
