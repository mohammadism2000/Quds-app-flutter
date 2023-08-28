import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FactScreen extends StatefulWidget {
  const FactScreen({Key? key}) : super(key: key);

  @override
  State<FactScreen> createState() => _FactScreenState();
}

class _FactScreenState extends State<FactScreen> {
  late FirebaseFirestore query;

  @override
  void initState() {
    query = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //list of facts jer
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'Facts for Jerusalem',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              StreamBuilder<QuerySnapshot>(
                  stream: query.collection('facts').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    QuerySnapshot? querySnapshot = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: querySnapshot!.size,
                      itemBuilder: (context, index) =>
                          itemfact(double.infinity, index, querySnapshot),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Container itemfact(
      double sizeHeight, int index, QuerySnapshot? querySnapshot) {
    return Container(
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
        initiallyExpanded: false,
        title: Text(
          '${querySnapshot!.docs[index].get('title')}',
          textDirection: TextDirection.rtl,
        ),
        children: [
          Text(
            '${querySnapshot!.docs[index].get('desc')}',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 18, height: 1.4),
          ),
        ],
      ),
    );
  }
}
