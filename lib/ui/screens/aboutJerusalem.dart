import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutJerusalem extends StatefulWidget {
  const AboutJerusalem();
  @override
  _AboutJerusalemState createState() => _AboutJerusalemState();
}

class _AboutJerusalemState extends State<AboutJerusalem> {
  late FirebaseFirestore query;

  @override
  void initState() {
    query = FirebaseFirestore.instance;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: query.collection('ListVideo').snapshots(),
      builder: (context, stream) {
        if (stream.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (stream.hasError) {
          return Center(child: Text(stream.error.toString()));
        }

        QuerySnapshot? querySnapshot = stream.data;

        return ListView.builder(
          itemCount: querySnapshot?.size,
          itemBuilder: (context, index) => viedcard(index, querySnapshot),
        );
      },
    );
  }
}

Widget viedcard(int index, QuerySnapshot? querySnapshot) {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(
        '${querySnapshot!.docs[index].get('video')}')!,
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
    ),
  );

  //list of video
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          child: Container(
              child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ))),
      Text(
        '${querySnapshot.docs[index].get('discerption')}',
        style: TextStyle(color: Colors.grey, fontSize: 14),
        textAlign: TextAlign.right,
      ),
    ],
  );
}
