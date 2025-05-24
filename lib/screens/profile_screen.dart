import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/wallet_components.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Layout2(
        children: [
          // Profile image
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://ui-avatars.com/api/?name=Jhon%20Doe&background=FF5733&color=fff&rounded=true&size=256'), // Change to your asset path
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
             SizedBox(height: 32),
            // Row with 3 columns
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First square
                _ProfileStatBox(number: '15', title: 'Predictions'),
                SizedBox(width: 16),
                // Second square
                _ProfileStatBox(number: '80%', title: 'Accuracy'),
                SizedBox(width: 16),
                // Third square
                _ProfileStatBox(number: '3ETH', title: 'Rewards'),
              ],
            ),
            SizedBox(height: 32),
      // Voting history section
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Voting history",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Voting history list
            Column(
              children: [
                _VotingHistoryRow(
                  imageUrl: 'https://a.espncdn.com/i/teamlogos/nba/500/lal.png',
                  title: 'Lakers vs Warriors',
                  description: 'Voted: Lakers win by 5+ points.',
                ),
                SizedBox(height: 12),
                _VotingHistoryRow(
                  imageUrl: 'https://a.espncdn.com/i/teamlogos/nba/500/bos.png',
                  title: 'Celtics vs Heat',
                  description: 'Voted: Celtics score over 110.',
                ),
                SizedBox(height: 12),
                _VotingHistoryRow(
                  imageUrl: 'https://a.espncdn.com/i/teamlogos/nba/500/mil.png',
                  title: 'Bucks vs Nets',
                  description: 'Voted: Giannis gets a double-double.',
                ),
              ],
            ),
          ],
        ),
      ),

          SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              WalletSelector(),
              AccountAddress(),
              DeployAccountButton(),
            ],
          ),
          SizedBox(height: 32),
          WalletBody(),
          SendEthButton(),
          WalletErrorHandler(),
        ],
      ),
    );
  }
}

// Add this widget below your ProfileScreen class (outside of it)
class _ProfileStatBox extends StatelessWidget {
  final String number;
  final String title;

  const _ProfileStatBox({required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Add this widget below your _ProfileStatBox class (outside of it)
class _VotingHistoryRow extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const _VotingHistoryRow({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}