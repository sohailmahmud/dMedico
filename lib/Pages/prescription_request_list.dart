import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medico/Pages/appointment_form.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medico/utils/PrescriptionModel.dart';

class PrescriptionRequestList extends StatefulWidget {
  @override
  PrescriptionRequestListState createState() {
    return new PrescriptionRequestListState();
  }
}

class PrescriptionRequestListState extends State<PrescriptionRequestList> {
  
  Future<List<PrescriptionModel>> getPrescs() async
  {
    List<PrescriptionModel> values=[];
    await FirebaseDatabase.instance.reference().child('9620908970').child('prescriptions').once().then((snap){
      snap.value.forEach((key,vals) {
        values.add(PrescriptionModel(
          date: vals['date'],
          symptoms: vals['symptoms'],
          medicines: vals['medicines'],
          diagnosis: vals['diagnosis'],));
      });
    });
    print(values);
    return values;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: getPrescs(),
      builder: (ctx,snap)
        {
          if(snap.hasData)
            {
             return getList(snap.data);
            }
            else
              {return Center(child: CircularProgressIndicator());}
        },),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return AppointmentForm();
            }));
          },
        ),
      ),
    );
  }

  Widget getList(List<PrescriptionModel> data) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.assignment_ind),
                  title: Text(data[index].diagnosis),
                  subtitle: Text(data[index].medicines),
                ),
                Row(
                  children: <Widget>[
                    FlatButton(
                      child: const Text("Request 2nd Opinions"),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
