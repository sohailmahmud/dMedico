import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MedicineReview extends StatelessWidget {
  int index;

  MedicineReview(this.index);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (ctx, i) {
          return i == 0 ? buildMedicineDescription() : buildReviews(context,i);
        },
      ),
    );
  }

  Card buildMedicineDescription() {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: CachedNetworkImageProvider('https://images.theconversation.com/files/101120/original/image-20151106-16242-12xhw43.jpg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(index==0?'Calpal':index==1?'Crocin':'Doloris', style: TextStyle(fontSize: 18.0)),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(index==0?'For Fever':index==1?'For Headache':'Body Pain'),
          )
        ]),
      ),
    );
  }

  ListTile buildReviews(BuildContext context,int ind) {
    return ListTile(
      leading: Icon(Icons.add_alarm),
      title: Text(ind==1?'Anoop':'Gaurav'),
      subtitle: Text(ind==1?'A good medicine':'Helped a lot'),
      trailing: SmoothStarRating(
        allowHalfRating: false,
        starCount: 5,
        rating: ind==1?3.5:4.5,
        size: 10.0,
        color: Colors.yellow,
        borderColor: Colors.grey,
      ),
    );
  }
}
