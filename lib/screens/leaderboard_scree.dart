import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> players = const [
    {
      "name": "Ethan Walker",
      "accuracy": 95,
      "amount": 150,
      "avatar": "https://via.placeholder.com/64",
    },
    {
      "name": "Chloe Bennett",
      "accuracy": 92,
      "amount": 120,
      "avatar": "https://via.placeholder.com/64",
    },
    {
      "name": "Owen Carter",
      "accuracy": 90,
      "amount": 100,
      "avatar": "https://via.placeholder.com/64",
    },
    {
      "name": "Lily Davis",
      "accuracy": 88,
      "amount": 80,
      "avatar": "https://via.placeholder.com/64",
    },
    {
      "name": "Noah Evans",
      "accuracy": 85,
      "amount": 60,
      "avatar": "https://via.placeholder.com/64",
    },
    {
      "name": "Ava Foster",
      "accuracy": 82,
      "amount": 40,
      "avatar": "https://via.placeholder.com/64",
    },
    {
      "name": "Liam Gray",
      "accuracy": 80,
      "amount": 30,
      "avatar": "https://via.placeholder.com/64",
    },
    {
      "name": "Isabella Hayes",
      "accuracy": 78,
      "amount": 20,
      "avatar": "https://via.placeholder.com/64",
    },
    {
      "name": "Mason Ingram",
      "accuracy": 75,
      "amount": 10,
      "avatar": "https://via.placeholder.com/64",
    },
    {
      "name": "Mia Jenkins",
      "accuracy": 72,
      "amount": 5,
      "avatar": "https://via.placeholder.com/64",
    },
  ];

  Widget playerTile(int rank, Map<String, dynamic> player) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(player['avatar']),
        radius: 24,
      ),
      title: Text(
        "$rank. ${player['name']}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "Accuracy: ${player['accuracy']}%",
        style: const TextStyle(color: Color(0xFF7B7B39)),
      ),
      trailing: Text(
        "\$${player['amount']}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Leaderboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Top Players",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          for (int i = 0; i < players.length; i++)
            playerTile(i + 1, players[i]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Predictions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {},
      ),
    );
  }
}
