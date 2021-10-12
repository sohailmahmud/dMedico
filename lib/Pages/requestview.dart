import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RequestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 3,
          itemBuilder: (ctx, i) {
            return
              i==0?buildRequest():buildReview(i)
              ;
          }),
    ));
  }

  Card buildRequest() {
    return Card(
      child: Column(
        children: <Widget>[
          Text(
            "Your Illness",
            style: TextStyle(fontSize: 18.0,color: Colors.lightBlue),
          ),
          Text("Feverish"),
                    
        ],
      ),
    );
  }

  DecoratedBox buildImage() {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('./1.jpg')
        )
      ),
    );
  }

  Card buildReview(int ind) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  ind==1?'Dr. Sudhir C':'Dr. AP Jabbar',
                  style: TextStyle(fontSize: 18.0),
                ),
                Spacer(),
                SmoothStarRating(
                  allowHalfRating: false,
                  starCount: 5,
                  rating: ind==1?3.5:2,
                  size: 10.0,
                  color: Colors.yellow,
                  borderColor: Colors.grey,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(ind==1?'Satisfied By The Review':'You Can Try another Medicine'),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  child: const Text("Book Appointment"),
                  onPressed: () {},
                ),
                Spacer(),
                FlatButton(
                  child: const Text("Chat"),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
