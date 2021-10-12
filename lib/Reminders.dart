import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Reminders extends StatefulWidget {
  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text('Reminders'),
            centerTitle: true,),
            body: ListView.builder(itemCount: 2,itemBuilder: (ctx, index) {
              if(index%2==0)
                {return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        'https://images.theconversation.com/files/101120/original/image-20151106-16242-12xhw43.jpg'),
                  ),
                  title: Text('Take Your Calpal'),
                  subtitle: Text('2 Pills at 5:00 PM'),
                );}
                else
                  {return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          'http://topendtraveldoctor.com.au/wp-content/uploads/2016/12/anonymous-female.png'),
                    ),
                    title: Text('Meet Dr. AKM Asaduzzaman'),
                    subtitle: Text('At 8:00 PM'),
                  );}
            })));
  }
}
