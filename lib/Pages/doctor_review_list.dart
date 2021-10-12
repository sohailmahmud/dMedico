import 'package:flutter/material.dart';
import 'package:medico/Pages/doctor_review.dart';
import 'package:medico/Pages/medicine_review.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DoctorReviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (ctx, i) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return DoctorReview(i);
              }));
            },
            child: ListTile(
              leading: Icon(Icons.add_alarm),
              title: Text(i==0?'Dr. K P Ganesh':'Dr. Sudhir C'),
              subtitle: Text(i==0?'MBBS':'MBBS'),
              trailing:SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: i==0?2.5:4,
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
