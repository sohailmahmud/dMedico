import 'package:flutter/material.dart';

class AppointmentForm extends StatefulWidget {
  @override
  AppointmentFormState createState() {
    return new AppointmentFormState();
  }
}

class AppointmentFormState extends State<AppointmentForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Book Appointment'),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: this._formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Name Your Illness',
                          labelText: 'Title Of Illness')),
                  TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: 'Describe Your Illness',
                          labelText: 'Description')),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        hintText: 'mm/dd/yyyy', labelText: 'Date'),
                  ),
                  Container(
                    width: 10,
                    child: RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text('Appointment Requested'),
                                content:
                                    Text('Your appointment has been requested'),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Done'))
                                ],
                              );
                            });

                      },
                      color: Colors.blue,
                    ),
                    margin: EdgeInsets.only(top: 30.0),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
