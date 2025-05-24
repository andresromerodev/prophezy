import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wallet_kit/wallet_kit.dart';
import 'screens/profile_screen.dart';
import 'screens/leaderboard_scree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  WalletKit().init(
    accountClassHash: dotenv.env['ACCOUNT_CLASS_HASH'] as String,
    rpc: dotenv.env['RPC'] as String,
  );

  await Hive.initFlutter();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const ProviderScope(child: MyApp()));
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

class UpcomingMatchesScreen extends StatefulWidget {
  const UpcomingMatchesScreen({super.key});

  @override
  State<UpcomingMatchesScreen> createState() => _UpcomingMatchesScreenState();
}

class _UpcomingMatchesScreenState extends State<UpcomingMatchesScreen> {
  int _selectedIndex = 0;

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const _HomeContent();
      case 1:
        return const LeaderboardScreen();
      case 2:
        return const ProfileScreen();
      default:
        return const _HomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth < 600 ? screenWidth : 480.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Prophezy",
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
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),

      body: _getScreen(_selectedIndex),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

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

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: contentWidth,
          child: Column(
            children: [
              matchSection("Soccer", [
                'https://resources.premierleague.com/premierleague/photos/players/250x250/p165153.png',
                'https://resources.premierleague.com/premierleague/photos/players/250x250/p103025.png',
                'https://resources.premierleague.com/premierleague/photos/players/250x250/p165153.png',
              ]),
              matchSection("Basketball", [
                'https://cdn.nba.com/headshots/nba/latest/1040x760/2544.png',
                'https://cdn.nba.com/headshots/nba/latest/1040x760/203507.png',
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
