import 'package:flutter/material.dart';
import 'package:medico/Pages/medicine_review.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MedicineReviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (ctx, i) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return MedicineReview(i);
              }));
            },
            child: ListTile(
              leading: Icon(Icons.add_alarm),
              title: Text(i==0?'Calpal':i==1?'Crocin':'Doloris'),
              subtitle: Text(i==0?'For Fever':i==1?'For Headache':'Body Pain'),
              trailing:SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: i==0?3.5:i==1?4:4.5,
                size: 10.0,
                color: Colors.yellow,
                borderColor: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
