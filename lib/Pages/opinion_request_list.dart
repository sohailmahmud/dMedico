import 'package:flutter/material.dart';
import './prescription_request_list.dart';
import './requestview.dart';

class OpinionRequestList extends StatefulWidget {
  OpinionRequestList({Key key, this.title, this.subtitle}) : super(key: key);
  final String subtitle;
  final String title;

  @override
  _OpinionRequestListState createState() => _OpinionRequestListState();
}

class _OpinionRequestListState extends State<OpinionRequestList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: buildCard(index),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:60.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return PrescriptionRequestList();
            }));
          },
        ),
      ),
    );
  }

  Card buildCard(int ind) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.assignment_ind),
            title: Text(ind==0?'Feverish':ind==1?'InterGalactic Disorder':'Pale Eyes'),
            subtitle: Text(ind==0?'Penicilin':ind==1?'Goblin Juice with Powder':'Doloris200'),
          ),
          Row(
            children: <Widget>[
              ind==0?FlatButton(
                child: const Text("End Request"),
                onPressed: () {},
              ):SizedBox(),
              FlatButton(
                child: const Text("View Request"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return RequestView();
                  }));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
