import 'package:flutter/material.dart';

class PledgedByMeScreen extends StatelessWidget {
  final List<Map<String, String>> pledges = [
    {
      'name': 'Ahmed Sayed',
      'item': 'Play Station 5',
      'avatar': 'https://via.placeholder.com/50'
    },
    {
      'name': 'Amr Haythem',
      'item': 'New book',
      'avatar': 'https://via.placeholder.com/50'
    },
    {
      'name': 'Amr Mohamed',
      'item': 'Volvo car',
      'avatar': 'https://via.placeholder.com/50'
    },
    {
      'name': 'Ahmed Sayed',
      'item': 'iPhone 16 Pro',
      'avatar': 'https://via.placeholder.com/50'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pledged by me'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {},
        // ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: pledges.length,
        itemBuilder: (context, index) {
          final pledge = pledges[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16.0),
            elevation: 0,
            color: Color(0xFFFFF5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(pledge['avatar']!),
                radius: 25.0,
              ),
              title: Text(
                pledge['name']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                pledge['item']!,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
