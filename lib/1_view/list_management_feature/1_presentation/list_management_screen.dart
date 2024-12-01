import 'package:flutter/material.dart';

import '../../../3_model/models/event.dart';
import '../../../core/config/app_router.dart';

class ListManagementScreen extends StatelessWidget {
  final Event event;

  const ListManagementScreen({
    Key? key,
    required this.event
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Column(
          children: [
            Text(
              event.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              event.date.toString(),
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView(
                        children: const [
                          ListItem(
                              title: "Play Station 5",
                              imageUrl: "https://via.placeholder.com/150"),
                          Divider(color: Colors.white, thickness: 1),
                          ListItem(title: "New book"),
                          Divider(color: Colors.white, thickness: 1),
                          ListItem(title: "Volvo car"),
                          Divider(color: Colors.white, thickness: 1),
                          ListItem(title: "iPhone 16 Pro"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AddButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.addGiftsScreenRoute);
                    },
                  ),
                ],
              ),
            ),
          ),
          // const ActionButtons(),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String? imageUrl;

  const ListItem({
    Key? key,
    required this.title,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      ),
      trailing: imageUrl != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(imageUrl!),
            )
          : null,
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({Key? key, required this.onPressed}) : super(key: key);
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          "Add",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
