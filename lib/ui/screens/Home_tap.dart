import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quds1_flutter/ui/screens/details_screen.dart';

class HomeTap extends StatefulWidget {
  const HomeTap();

  @override
  _HomeTapState createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  late FirebaseFirestore query;

  @override
  void initState() {
    query = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
  // list of posts
    return StreamBuilder<QuerySnapshot>(
      stream: query.collection('Posteitem').snapshots(),
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
          itemBuilder: (context, index) =>
              itempost(sizeHeight, index, querySnapshot),
        );
      },
    );
  }
// item of post
  Container itempost(
      double sizeHeight, int index, QuerySnapshot? querySnapshot) {
    return Container(
        child: Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    image: querySnapshot!.docs[index].get('image'),
                    details: querySnapshot.docs[index].get('detaalse'),
                    like: querySnapshot.docs[index].get('like'),
                  ),
                ));
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: sizeHeight / 2.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(17)),
              color: Colors.amber,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.network(
                  '${querySnapshot!.docs[index].get('image')}',
                  fit: BoxFit.cover,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              InkWell(
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onTap: () {
                  onPressedLike(querySnapshot.docs[index].id);
                },
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                '${querySnapshot.docs[index].get('like')},',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
        ),
      ],
    ));
  }
 //like in post
  void onPressedLike(String id) {
    var firebaseUser = query.collection('Posteitem').doc(id);

    firebaseUser.update({'like': FieldValue.increment(1)});
  }
}
