import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Profile image
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('https://ui-avatars.com/api/?name=John Doe&background=FF5733&color=fff&rounded=true&size=256'), // Change to your asset path
            ),
            SizedBox(height: 16),
            // Username
            Text(
              "John Doe",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // @account
            Text(
              "@johndoe",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}