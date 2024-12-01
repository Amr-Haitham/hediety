import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hediety/core/config/app_router.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                const ProfileHeader(),
                const SizedBox(height: 40),
                RedButton(
                    label: "My lists",
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.myEventsScreenRoute);
                    }),
                const SizedBox(height: 16),
                RedButton(
                    label: "pledged by me",
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Routes.pledgedByMeScreenRoute);
                    }),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: LogoutButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
              "https://via.placeholder.com/150"), // Replace with your image URL
        ),
        const SizedBox(height: 12),
        const Text(
          "Ahmed Mohamed",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class RedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const RedButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) =>
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.authWrapper, (route) => false));
        },
        child: const Text(
          "Log out",
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  }
}
