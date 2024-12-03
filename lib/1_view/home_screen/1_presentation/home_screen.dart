import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/1_view/authentication/presentation/manager/authentication_op/authentication_op_cubit.dart';
import 'package:hediety/3_data_layer/models/app_user.dart';
import '../../../../core/config/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/buttons/button_widget.dart';
import '../../../../core/widgets/text_fields/text_field.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.profileScreenRoute);
          },
          child: const Text(
            "Ahmed Mohamed",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        leading: const CircleAvatar(
          backgroundImage: NetworkImage(
              "https://via.placeholder.com/150"), // Replace with your image URL
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.red),
            onPressed: () {
              Navigator.pushNamed(context, Routes.notificationsScreenRoute);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SearchBar(),
            const SizedBox(height: 20),
            CardList(
              cardsData: [
                {
                  'title': "My Birthday",
                  'name': "Ahmed Sayed",
                  'date': "22 / 10 / 2024",
                  'imageUrl': "https://via.placeholder.com/150"
                },
                {
                  'title': "My Birthday",
                  'name': "Amr Haythem",
                  'date': "22 / 10 / 2024",
                  'imageUrl': null
                },
                {
                  'title': "Wedding Party",
                  'name': "Amr Mohamed",
                  'date': "22 / 10 / 2024",
                  'imageUrl': "https://via.placeholder.com/150"
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {

   
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search by name or email",
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
          filled: true,
          fillColor: Colors.pink[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final List<Map<String, dynamic>> cardsData;

  const CardList({Key? key, required this.cardsData}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.cardsData.map((cardData) {
        return EventCard(
          onTap: () {
            // Navigator.pushNamed(context, Routes.l);
          },
          title: cardData['title'],
          name: cardData['name'],
          date: cardData['date'],
          imageUrl: cardData['imageUrl'],
        );
      }).toList(),
    );
  }
}

class EventCard extends StatefulWidget {
  final String title;
  final String name;
  final String date;
  final String? imageUrl;
  final Function()? onTap;

  const EventCard({
    Key? key,
    required this.title,
    required this.name,
    required this.onTap,
    required this.date,
    this.imageUrl,
  }) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.pink[50],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (widget.imageUrl != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl!),
                    radius: 30,
                  )
                else
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.date,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.card_giftcard, color: Colors.red, size: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
