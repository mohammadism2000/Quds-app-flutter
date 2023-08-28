import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.image,
    required this.details,
    required this.like,
  }) : super(key: key);

  final String image;
  final String details;
  final int like;

  @override
  Widget build(BuildContext context) {

    //details post screen
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 500,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Like: $like',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Details: $details',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
