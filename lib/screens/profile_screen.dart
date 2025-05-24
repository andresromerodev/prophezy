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
