import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'name': 'Ahmed Mohmed',
      'action': 'has pledged your item',
      'date': '12 / 12 / 2024',
      'avatar': 'https://via.placeholder.com/50',
      'isNew': true,
    },
    {
      'name': 'Mohamed Ahmed',
      'action': 'has broken his pledge',
      'date': '12 / 12 / 2024',
      'avatar': 'https://via.placeholder.com/50',
      'isNew': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(notification['avatar']),
                  radius: 25.0,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: notification['name'] + ' ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: notification['action']),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        notification['date'],
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
                if (notification['isNew'])
                  Icon(Icons.circle, color: Colors.red, size: 10.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
