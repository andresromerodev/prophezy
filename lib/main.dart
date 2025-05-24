import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const UpcomingMatchesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UpcomingMatchesScreen extends StatelessWidget {
  const UpcomingMatchesScreen({super.key});

  Widget sectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
    child: Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );

  Widget predictionButtons() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text("Predict Win"),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF6F5F3),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text("Predict Lose"),
          ),
        ),
      ],
    ),
  );

  Widget videoCard(String imageUrl) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const Icon(Icons.play_circle, size: 50, color: Colors.white),
      ],
    ),
  );

  Widget matchSection(String category, List<String> imageUrls) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(category),
      for (var image in imageUrls) ...[videoCard(image), predictionButtons()],
    ],
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth < 600 ? screenWidth : 480.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upcoming Matches",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: contentWidth,
            child: Column(
              children: [
                matchSection("UFC", [
                  'https://placehold.co/400x200?text=UFC+1',
                  'https://placehold.co/400x200?text=UFC+2',
                  'https://placehold.co/400x200?text=UFC+3',
                ]),
                matchSection("Basketball", [
                  'https://placehold.co/400x200?text=Basketball+1',
                  'https://placehold.co/400x200?text=Basketball+2',
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
